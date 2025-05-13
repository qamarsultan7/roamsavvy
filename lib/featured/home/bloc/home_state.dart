import 'package:equatable/equatable.dart';

// Location model
class Location {
  final String id;
  final String name;
  final String address;
  
  const Location({
    required this.id, 
    required this.name, 
    required this.address
  });
}

abstract class LocationState extends Equatable {
  const LocationState();
  
  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final Location currentLocation;
  final List<Location> savedLocations;
  
  const LocationLoaded({
    required this.currentLocation,
    required this.savedLocations,
  });
  
  @override
  List<Object> get props => [currentLocation, savedLocations];
  
  LocationLoaded copyWith({
    Location? currentLocation,
    List<Location>? savedLocations,
  }) {
    return LocationLoaded(
      currentLocation: currentLocation ?? this.currentLocation,
      savedLocations: savedLocations ?? this.savedLocations,
    );
  }
}

class LocationError extends LocationState {
  final String message;
  
  const LocationError(this.message);
  
  @override
  List<Object> get props => [message];
}
