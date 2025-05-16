import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsState.initial()) {
    on<UpdateThemeEvent>(_onUpdateTheme);
  }

  void _onUpdateTheme(UpdateThemeEvent event, Emitter<SettingsState> emit) {
    emit(state.copyWith(themeMode: event.themeMode));
  }
}
