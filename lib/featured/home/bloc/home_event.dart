part of 'home_bloc.dart';

sealed class HomeEvent {
  const HomeEvent();
}

class ToggleIsEditingEvent extends HomeEvent {
  const ToggleIsEditingEvent();
}

class StartHeadingAnimationEvent extends HomeEvent {
  const StartHeadingAnimationEvent();
}

class CompleteHeadingAnimationEvent extends HomeEvent {
  const CompleteHeadingAnimationEvent();
}

class RotateHeadingEvent extends HomeEvent {
  const RotateHeadingEvent();
}

class ToggleExpandedWidget extends HomeEvent {
  const ToggleExpandedWidget();
}

class GetFoodPointsDataEvent extends HomeEvent {
  
  const GetFoodPointsDataEvent();
}

class GetNearByFoodPointsEvent extends HomeEvent {
  final String lat;
  final String lng;
  const GetNearByFoodPointsEvent({
    required this.lat,
    required this.lng,
  });
}
