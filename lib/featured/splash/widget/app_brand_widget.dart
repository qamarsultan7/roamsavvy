import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AppBrandingWidget extends StatelessWidget {
  const AppBrandingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 220,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // App name animation
              Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedLettersDrop(),
              ),

              // App icon animation
              Image.asset('assets/icons/app_icon1.png', width: 180, height: 180)
                  .animate(delay: const Duration(seconds: 3))
                  .scale()
                  .slideY(
                    begin: 0.0,
                    end: -0.1,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Text(
              'Your travel companion',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withAlpha(190),
              ),
            )
            .animate(delay: const Duration(seconds: 4))
            .fadeIn(duration: const Duration(milliseconds: 400)),
      ],
    );
  }
}

class AnimatedLettersDrop extends StatelessWidget {
  const AnimatedLettersDrop({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = 'ROAMSAVVY';

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
          text.characters.toList().asMap().entries.map((entry) {
            final index = entry.key;
            final char = entry.value;
            return Text(
                  char,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                )
                .animate(delay: Duration(seconds: 3))
                .fadeIn(duration: const Duration(milliseconds: 400))
                .slideY(
                  begin: -1.1,
                  end: 0,
                  delay: Duration(milliseconds: 100 * index),
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOut,
                );
          }).toList(),
    );
  }
}
