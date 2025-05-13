import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<ToggleIsEditingEvent>(_onToggleIsEditing);
  }

  void _onToggleIsEditing(
    ToggleIsEditingEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(isEditing: !state.isEditing));
  }
}
