part of 'bottom_nav_bar_bloc.dart';

sealed class BottomNavBarEvent {
  const BottomNavBarEvent();
}

class BottomNavBarItemTapped extends BottomNavBarEvent {
  final int index;
  const BottomNavBarItemTapped({required this.index});
}
