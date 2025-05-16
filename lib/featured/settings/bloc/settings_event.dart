part of 'settings_bloc.dart';

sealed class SettingsEvent {
  const SettingsEvent();
}

class UpdateThemeEvent extends SettingsEvent {
  final ThemeMode themeMode;
  const UpdateThemeEvent(this.themeMode);
}