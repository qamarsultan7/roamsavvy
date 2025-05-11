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
      animationPath: "assets/animations/food-delivery.json",
    ),
    OnboardingContent(
      title: "Plan Your Journey",
      description: "Create personalized travel itineraries and stay organized.",
      animationPath: "assets/animations/drink.json",
    ),
    OnboardingContent(
      title: "Travel Like a Local",
      description:
          "Get insider tips and recommendations for an authentic experience.",
      animationPath: "assets/animations/Fast delivery.json",
    ),
  ];

  OnboardingBloc() : super(const OnboardingState(0)) {
    on<OnboardingPageChanged>(_onPageChanged);
    on<OnboardingNextPage>(_onNextPage);
    on<OnboardingSkipped>(_onSkipped);
    on<OnboardingCompleted>(_onCompleted);
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
      emit(state.copyWith(currentPageIndex:event.currentPageIndex + 1));
    } else {
      // If on the last page, complete the onboarding
      emit(state.copyWith());
    }
  }

  void _onSkipped(OnboardingSkipped event, Emitter<OnboardingState> emit) {
    emit(state.copyWith());
  }

  void _onCompleted(OnboardingCompleted event, Emitter<OnboardingState> emit) {
    emit(state.copyWith());
  }
}
