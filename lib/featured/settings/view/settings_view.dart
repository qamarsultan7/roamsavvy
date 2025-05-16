import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  // Theme mode selection
  final ThemeMode _currentThemeMode = ThemeMode.system;
  // Language selection (just UI)

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), elevation: 0),
      body: ListView(
        children: [
          // Theme settings section
          _buildSectionHeader('Theme Settings'),
          _buildThemeSelector(),

          const Divider(),

          // Language settings section
          _buildSectionHeader('Language Settings'),
          _buildLanguageSelector(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildThemeSelector() {
    return Column(
      children: [
        RadioListTile<ThemeMode>(
          title: const Text('Light Theme'),
          secondary: const Icon(Icons.light_mode),
          value: ThemeMode.light,
          groupValue: _currentThemeMode,
          onChanged: (ThemeMode? value) {},
        ),
        RadioListTile<ThemeMode>(
          title: const Text('Dark Theme'),
          secondary: const Icon(Icons.dark_mode),
          value: ThemeMode.dark,
          groupValue: _currentThemeMode,
          onChanged: (ThemeMode? value) {},
        ),
        RadioListTile<ThemeMode>(
          title: const Text('System Theme'),
          secondary: const Icon(Icons.settings_system_daydream),
          value: ThemeMode.system,
          groupValue: _currentThemeMode,
          onChanged: (ThemeMode? value) {},
        ),
      ],
    );
  }

  Widget _buildLanguageSelector() {
    return RadioListTile<String>(
      title: Text('language'),
      value: 'language',
      groupValue: 'language',
      onChanged: (String? value) {},
    );
  }
}
