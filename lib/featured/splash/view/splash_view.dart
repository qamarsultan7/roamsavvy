import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Get current theme (light or dark)

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 100),

          // Logo placeholder
          Icon(Icons.explore, size: 80, color: theme.colorScheme.primary),

          const SizedBox(height: 20),
          Text(
            'Welcome to\nROAMSAVVY',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Your travel companion',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withAlpha(190),
            ),
          ),
        ],
      ),
    );
  }
}
