import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  /// Check and request location permissions
  Future<bool> checkLocationPermission() async {
    final status = await Permission.location.request();

    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }

    return false;
  }

  /// Get current location (latitude & longitude)
  Future<Position?> getCurrentPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint("Location services are disabled.");
      return null;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint("Location permissions are permanently denied.");
      return null;
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  /// Convert lat/lng to human-readable address
  Future<String> getAddressFromLatLng(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        return "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
      }
    } catch (e) {
      debugPrint("Error in reverse geocoding: $e");
    }
    return "Address not found";
  }

  /// Combined function: Get readable address from current location
  Future<String> getCurrentLocationAddress() async {
    bool hasPermission = await checkLocationPermission();
    if (!hasPermission) return "Location permission denied.";

    final position = await getCurrentPosition();
    if (position == null) return "Could not get location.";

    return await getAddressFromLatLng(position.latitude, position.longitude);
  }
}
