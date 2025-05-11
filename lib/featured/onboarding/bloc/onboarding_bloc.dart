import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/onboarding_content.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final List<OnboardingContent> contents = [
    OnboardingContent(
      title: "Discover New Places",
      description:
          "Find amazing destinations around the world with just a few taps.",
      image: "assets/images/8.jpg",
    ),
    OnboardingContent(
      title: "Plan Your Journey",
      description: "Create personalized travel itineraries and stay organized.",
      image: "assets/images/11.jpg",
    ),
    OnboardingContent(
      title: "Travel Like a Local",
      description:
          "Get insider tips and recommendations for an authentic experience.",
      image: "assets/images/12.jpg",
    ),
    OnboardingContent(
      title: "Travel Like a Local",
      description:
          "Get insider tips and recommendations for an authentic experience.",
      image: "assets/images/14.jpg",
    ),
    OnboardingContent(
      title: "Travel Like a Local",
      description:
          "Get insider tips and recommendations for an authentic experience.",
      image: "assets/images/15.jpg",
    ),
  ];

  OnboardingBloc() : super(const OnboardingState(currentPageIndex: 0)) {
    on<OnboardingPageChanged>(_onPageChanged);
    on<OnboardingNextPage>(_onNextPage);
    on<OnboardingSkipped>(_onSkipped);
    on<OnboardingCompleted>(_onCompleted);
    on<OnboardingPageOffsetChanged>(_onUpdateOffSet);
  }

  void _onPageChanged(
    OnboardingPageChanged event,
    Emitter<OnboardingState> emit,
  ) {
    emit(state.copyWith(currentPageIndex: event.pageIndex));
  }

  void _onNextPage(OnboardingNextPage event, Emitter<OnboardingState> emit) {
    if (event.currentPageIndex < event.totalPages - 1) {
      // If not on the last page, just move to the next page
      emit(state.copyWith(currentPageIndex: event.currentPageIndex + 1));
    } else {
      // If on the last page, complete the onboarding
      emit(state.copyWith(isCompleted: true));
    }
  }

  void _onSkipped(OnboardingSkipped event, Emitter<OnboardingState> emit) {
    // Mark onboarding as completed when skipped
    emit(state.copyWith(isCompleted: true));
  }

  void _onCompleted(OnboardingCompleted event, Emitter<OnboardingState> emit) {
    // Mark onboarding as completed
    emit(state.copyWith(isCompleted: true));
  }

  void _onUpdateOffSet(
    OnboardingPageOffsetChanged event,
    Emitter<OnboardingState> emit,
  ) {
    emit(state.copyWith(pageOffset: event.offset));
  }
}
