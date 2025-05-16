import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
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
      emit(state.copyWith(status: LocationStatus.granted));
      try {
        final position = await Geolocator.getCurrentPosition();
        Placemark? place;
        try {
          final placemarks = await placemarkFromCoordinates(
            position.latitude,
            position.longitude,
          );
          place = placemarks.first;
        } on PlatformException {
          emit(
            state.copyWith(
              status: LocationStatus.error,
              errorMessage: "Check Your Internet Connection",
            ),
          );
          return;
        } catch (e) {
          emit(
            state.copyWith(
              status: LocationStatus.error,
              errorMessage:
                  "Unexpected error during geocoding: ${e.toString()}",
            ),
          );
          return;
        }

        emit(state.copyWith(status: LocationStatus.granted, address: place));
      } on PlatformException catch (e) {
        emit(
          state.copyWith(
            status: LocationStatus.error,
            errorMessage: "PlatformException: ${e.message}",
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            status: LocationStatus.error,
            errorMessage: "Unexpected error: ${e.toString()}",
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
