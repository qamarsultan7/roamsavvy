part of 'bottom_nav_bar_bloc.dart';

class BottomNavBarState extends Equatable {
  final int previousIndex;
  final int selectedIndex;
  const BottomNavBarState({this.previousIndex = 0, this.selectedIndex = 0});

  @override
  List<Object> get props => [previousIndex, selectedIndex];
}
