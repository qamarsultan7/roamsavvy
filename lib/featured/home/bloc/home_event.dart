import 'package:equatable/equatable.dart';
import 'package:roamsavvy/featured/home/bloc/home_state.dart';

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
