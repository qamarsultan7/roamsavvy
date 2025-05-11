
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
          height: 250,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // App name animation
              Positioned(
                top: 180,
                child: Text(
                      'ROAMSAVVY',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    )
                    .animate(delay: const Duration(seconds: 11))
                    .fadeIn(duration: const Duration(milliseconds: 800))
                    .slideY(
                      begin: -0.4,
                      end: 0.8,
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeInOut,
                    ),
              ),

              // App icon animation
              Image.asset('assets/icons/app_icon1.png', width: 180, height: 180)
                  .animate(delay: const Duration(seconds: 10))
                  .scale()
                  .slideY(
                    begin: 0.0,
                    end: -0.1,
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeInOut,
                  ),
            ],
          ),
        ),

        Text(
              'Your travel companion',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withAlpha(190),
              ),
            )
            .animate(delay: const Duration(seconds: 10))
            .fadeIn(duration: const Duration(milliseconds: 800)),
      ],
    );
  }
}
