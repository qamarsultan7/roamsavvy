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
