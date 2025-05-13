import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

// Events
abstract class LocationEvent extends Equatable {
  const LocationEvent();
  
  @override
  List<Object> get props => [];
}

class LoadCurrentLocation extends LocationEvent {}

class SelectLocation extends LocationEvent {
  final Location location;
  
  const SelectLocation(this.location);
  
  @override
  List<Object> get props => [location];
}

// States
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

// BLoC
class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    on<LoadCurrentLocation>(_onLoadCurrentLocation);
    on<SelectLocation>(_onSelectLocation);
  }
  
  void _onLoadCurrentLocation(
    LoadCurrentLocation event,
    Emitter<LocationState> emit,
  ) async {
    emit(LocationLoading());
    
    try {
      // Simulate API call with delay
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock data - in real app, this would come from a location service
      final currentLocation = Location(
        id: '1',
        name: 'New York City',
        address: '123 Main St, New York, NY, USA',
      );
      
      final savedLocations = [
        Location(
          id: '2',
          name: 'San Francisco',
          address: '456 Market St, San Francisco, CA, USA',
        ),
        Location(
          id: '3',
          name: 'Los Angeles',
          address: '789 Hollywood Blvd, Los Angeles, CA, USA',
        ),
        Location(
          id: '4',
          name: 'Chicago',
          address: '321 Michigan Ave, Chicago, IL, USA',
        ),
      ];
      
      emit(LocationLoaded(
        currentLocation: currentLocation,
        savedLocations: savedLocations,
      ));
    } catch (e) {
      emit(LocationError('Failed to load location data'));
    }
  }
  
  void _onSelectLocation(
    SelectLocation event,
    Emitter<LocationState> emit,
  ) {
    if (state is LocationLoaded) {
      final currentState = state as LocationLoaded;
      emit(currentState.copyWith(currentLocation: event.location));
    }
  }
}
