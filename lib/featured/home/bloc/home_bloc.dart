import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  Timer? _headingTimer;

  HomeBloc() : super(const HomeState()) {
    on<ToggleIsEditingEvent>(_onToggleIsEditing);
    on<StartHeadingAnimationEvent>(_onStartHeadingAnimation);
    on<CompleteHeadingAnimationEvent>(_onCompleteHeadingAnimation);
    on<RotateHeadingEvent>(_onRotateHeading);
    on<ToggleExpandedWidget>(_onToggleExpandedWidget);
    // Start heading rotation when bloc is created
    add(const RotateHeadingEvent());
  }

  void _onToggleIsEditing(ToggleIsEditingEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(isEditing: !state.isEditing));
  }

  void _onStartHeadingAnimation(
    StartHeadingAnimationEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(isHeadingAnimating: true));

    // Schedule completion of animation - increased from 4000ms to 6000ms
    Future.delayed(const Duration(milliseconds: 5000), () {
      add(const CompleteHeadingAnimationEvent());
    });
  }

  void _onCompleteHeadingAnimation(
    CompleteHeadingAnimationEvent event,
    Emitter<HomeState> emit,
  ) {
    final nextIndex =
        (state.currentHeadingIndex + 1) % 4; // Assuming 4 headings
    emit(
      state.copyWith(currentHeadingIndex: nextIndex, isHeadingAnimating: false),
    );
  }

  void _onRotateHeading(RotateHeadingEvent event, Emitter<HomeState> emit) {
    // Cancel existing timer if any
    _headingTimer?.cancel();

    // Create a new timer that triggers animation every 7 seconds (increased from 5)
    _headingTimer = Timer.periodic(const Duration(seconds: 7), (timer) {
      if (!state.isHeadingAnimating) {
        add(const StartHeadingAnimationEvent());
      }
    });
  }

  void _onToggleExpandedWidget(
    ToggleExpandedWidget event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(isExpanded: !state.isExpanded));
  }

  @override
  Future<void> close() {
    _headingTimer?.cancel();
    return super.close();
  }
}
