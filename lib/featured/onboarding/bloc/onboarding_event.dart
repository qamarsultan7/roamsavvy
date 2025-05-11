abstract class OnboardingEvent {}

class OnboardingPageChanged extends OnboardingEvent {
  final int pageIndex;

  OnboardingPageChanged(this.pageIndex);
}

class OnboardingSkipped extends OnboardingEvent {}

class OnboardingCompleted extends OnboardingEvent {}

class OnboardingNextPage extends OnboardingEvent {
  final int currentPageIndex;
  final int totalPages;
  
  OnboardingNextPage({
    required this.currentPageIndex,
    required this.totalPages,
  });
}
