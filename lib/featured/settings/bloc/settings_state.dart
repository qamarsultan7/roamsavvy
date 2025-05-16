part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  final ThemeMode themeMode;
  const SettingsState({this.themeMode = ThemeMode.system});

  factory SettingsState.initial() {
    return const SettingsState();
  }

  SettingsState copyWith({ThemeMode? themeMode, String? language}) {
    return SettingsState(themeMode: themeMode ?? this.themeMode);
  }

  @override
  List<Object> get props => [themeMode];
}
