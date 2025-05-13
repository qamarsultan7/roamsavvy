part of 'home_bloc.dart';

enum HomeStatus { initial, loading, loaded, error }

class HomeState extends Equatable {
  final bool isEditing;
  final String currentLocation;
  const HomeState({this.isEditing = false, this.currentLocation = ''});

  HomeState copyWith({bool? isEditing, String? currentLocation}) {
    return HomeState(
      isEditing: isEditing ?? this.isEditing,
      currentLocation: currentLocation ?? this.currentLocation,
    );
  }

  @override
  List<Object?> get props => [isEditing, currentLocation];
}
