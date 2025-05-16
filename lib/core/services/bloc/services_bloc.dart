import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

part 'services_event.dart';
part 'services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  ServicesBloc() : super(ServicesState.initial()) {
    on<RequestLocationPermission>(_onRequestLocation);
  }

  Future<void> _onRequestLocation(
    RequestLocationPermission event,
    Emitter<ServicesState> emit,
  ) async {
    emit(state.copyWith(status: LocationStatus.loading));

    final status = await Permission.location.request();

    if (status.isGranted) {
      try {
        final position = await Geolocator.getCurrentPosition();
        final placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        final place = placemarks.first;
        final address =
            "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
        emit(state.copyWith(status: LocationStatus.granted, address: address));
      } catch (e) {
        emit(
          state.copyWith(
            status: LocationStatus.error,
            errorMessage: e.toString(),
          ),
        );
      }
    } else if (status.isPermanentlyDenied) {
      emit(state.copyWith(status: LocationStatus.permanentlyDenied));
    } else {
      emit(state.copyWith(status: LocationStatus.denied));
    }
  }
}
