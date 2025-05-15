import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_nav_bar_event.dart';
part 'bottom_nav_bar_state.dart';

class BottomNavBarBloc extends Bloc<BottomNavBarEvent, BottomNavBarState> {
  BottomNavBarBloc() : super(BottomNavBarState()) {
    on<BottomNavBarItemTapped>(_onTappedUpdateIndex);
  }

  void _onTappedUpdateIndex(
    BottomNavBarItemTapped event,
    Emitter<BottomNavBarState> emit,
  ) {
    emit(
      BottomNavBarState(
        previousIndex: state.selectedIndex,
        selectedIndex: event.index,
      ),
    );
  }
}
