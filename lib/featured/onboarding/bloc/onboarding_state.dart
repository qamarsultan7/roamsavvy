import 'package:equatable/equatable.dart';

class OnboardingState extends Equatable {
  final int currentPageIndex;
  final bool isCompleted;
  
  const OnboardingState(
    this.currentPageIndex, {
    this.isCompleted = false,
  });
  
  OnboardingState copyWith({
    int? currentPageIndex,
    bool? isCompleted,
  }) {
    return OnboardingState(
      currentPageIndex ?? this.currentPageIndex,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
  
  @override
  List<Object> get props => [currentPageIndex, isCompleted];
}
