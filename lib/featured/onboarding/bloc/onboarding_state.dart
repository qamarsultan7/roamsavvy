import 'package:equatable/equatable.dart';

class OnboardingState extends Equatable {
  final int currentPageIndex;
  final bool isCompleted;
  final double pageOffset;
  const OnboardingState({
    this.isCompleted = false,
    this.pageOffset = 0.0,
    required this.currentPageIndex,
  });

  OnboardingState copyWith({
    int? currentPageIndex,
    bool? isCompleted,
    double? pageOffset,
  }) {
    return OnboardingState(
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
      isCompleted: isCompleted ?? this.isCompleted,
      pageOffset: pageOffset ?? this.pageOffset,
    );
  }

  @override
  List<Object> get props => [currentPageIndex, isCompleted];
}
