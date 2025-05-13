part of 'home_bloc.dart';

sealed class HomeEvent {
  const HomeEvent();
}


class ToggleIsEditingEvent extends HomeEvent {
  const ToggleIsEditingEvent();
}
