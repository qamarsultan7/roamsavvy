part of 'services_bloc.dart';

abstract class ServicesEvent  {
  const ServicesEvent();
}


class RequestLocationPermission extends ServicesEvent {}