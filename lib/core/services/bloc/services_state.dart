part of 'services_bloc.dart';

enum LocationStatus {
  initial,
  loading,
  granted,
  denied,
  permanentlyDenied,
  error,
}

class ServicesState extends Equatable {
  final LocationStatus status;
  final Placemark? address;
  final String? errorMessage;

  const ServicesState({required this.status, this.address, this.errorMessage});

  factory ServicesState.initial() =>
      const ServicesState(status: LocationStatus.initial);

  ServicesState copyWith({
    LocationStatus? status,
    Placemark? address,
    String? errorMessage,
  }) {
    return ServicesState(
      status: status ?? this.status,
      address: address ?? this.address,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, address, errorMessage];
}
