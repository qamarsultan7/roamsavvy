part of 'home_bloc.dart';

enum HomeStatus { initial, loading, loaded, error }

class HomeState extends Equatable {
  final bool isEditing;
  final String currentLocation;
  final bool isExpanded;
  final int currentHeadingIndex;
  final bool isHeadingAnimating;
  
  const HomeState({
    this.isEditing = false,
    this.isExpanded = false,
    this.currentLocation = '',
    this.currentHeadingIndex = 0,
    this.isHeadingAnimating = false,
  });

  HomeState copyWith({
    bool? isEditing, 
    String? currentLocation,
    bool? isExpanded,
    int? currentHeadingIndex,
    bool? isHeadingAnimating,
  }) {
    return HomeState(
      isExpanded: isExpanded ?? this.isExpanded,
      isEditing: isEditing ?? this.isEditing,
      currentLocation: currentLocation ?? this.currentLocation,
      currentHeadingIndex: currentHeadingIndex ?? this.currentHeadingIndex,
      isHeadingAnimating: isHeadingAnimating ?? this.isHeadingAnimating,
    );
  }

  @override
  List<Object?> get props => [isEditing, currentLocation, isExpanded, currentHeadingIndex, isHeadingAnimating];
}
