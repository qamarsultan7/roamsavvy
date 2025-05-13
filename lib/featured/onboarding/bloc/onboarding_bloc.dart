import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/onboarding_content.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final List<OnboardingContent> contents = [
    OnboardingContent(
      title: "Discover Nearby Essentials",
      description:
          "Find the best food spots and reliable medical facilities near you, wherever you are.",
      image: "assets/images/8.jpg",
    ),
    OnboardingContent(
      title: "Real Reviews from Real Travelers",
      description:
          "Make informed decisions with trustworthy insights from fellow travelers.",
      image: "assets/images/11.jpg",
    ),
    OnboardingContent(
      title: "Smart Location Assistance",
      description:
          "Our app uses your location to instantly suggest nearby essentials, fast and easy.",
      image: "assets/images/12.jpg",
    ),
    OnboardingContent(
      title: "Plan Ahead with Confidence",
      description:
          "Know where to go before you arrive—save places and build your personalized map.",
      image: "assets/images/14.jpg",
    ),
    OnboardingContent(
      title: "Travel Safer and Smarter",
      description:
          "Stay prepared with reliable support and recommendations—right when you need them.",
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
