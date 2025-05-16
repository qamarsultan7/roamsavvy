import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/settings_bloc.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        elevation: 0,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Theme settings section
                _buildSectionHeader('Theme Settings', theme),
                _buildCard(child: _buildThemeSelector(state.themeMode, theme)),

                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 12),
      child: Text(
        title,
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: child,
    );
  }

  Widget _buildThemeSelector(ThemeMode currentThemeMode, ThemeData theme) {
    return Column(
      children: [
        _buildThemeOption(
          title: 'Light Theme',
          icon: Icons.light_mode,
          value: ThemeMode.light,
          groupValue: currentThemeMode,
          theme: theme,
        ),
        Divider(color: theme.colorScheme.onSurface.withOpacity(0.1)),
        _buildThemeOption(
          title: 'Dark Theme',
          icon: Icons.dark_mode,
          value: ThemeMode.dark,
          groupValue: currentThemeMode,
          theme: theme,
        ),
        Divider(color: theme.colorScheme.onSurface.withOpacity(0.1)),
        _buildThemeOption(
          title: 'System Theme',
          icon: Icons.settings_system_daydream,
          value: ThemeMode.system,
          groupValue: currentThemeMode,
          theme: theme,
        ),
      ],
    );
  }

  Widget _buildThemeOption({
    required String title,
    required IconData icon,
    required ThemeMode value,
    required ThemeMode groupValue,
    required ThemeData theme,
  }) {
    final isSelected = value == groupValue;
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: () {
        context.read<SettingsBloc>().add(UpdateThemeEvent(value));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(
              icon,
              color:
                  isSelected
                      ? colorScheme.primary
                      : colorScheme.onSurface.withOpacity(0.6),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: isSelected ? colorScheme.primary : colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(Icons.check_circle, color: colorScheme.primary),
          ],
        ),
      ),
    );
  }
}
