import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:roamsavvy/featured/onboarding/widget/dot_indicator.dart';
import '../models/onboarding_content.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingContent content;
  final BoxConstraints constraints;
  final int currentIndex;
  final int length;

  const OnboardingPage({
    super.key,
    required this.content,
    required this.constraints,
    required this.currentIndex,
    required this.length,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate animation size for portrait mode
    final double animationSize = constraints.maxWidth * 0.85;
    final double screenHeight = constraints.maxHeight;

    // Portrait-only layout
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: screenHeight * 0.5, // More responsive height
          child: Stack(
            clipBehavior: Clip.none, // Allow elements to overflow
            alignment: Alignment.center,
            children: [
               Container(
                    width: animationSize,
                    height: animationSize + 90,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withAlpha(100),
                          blurRadius: 8,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.asset(
                        content.image,
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ), // Slow fade in
                    ),
                  )
                  .animate(key: ValueKey(content.title))
                  .slideX(
                    begin: 1.2, // Float in farther from right
                    end: 0,
                    duration: 800.ms,
                    delay: 150.ms,
                    curve: Curves.easeOutCirc,
                  )
                  .fadeIn(duration: 500.ms)
                  .then(delay: 200.ms),

              // Animation at left with slight offset for visual interest
              Positioned(
                left: -animationSize * 0.15,
                child: SizedBox(
                      width: constraints.maxWidth * 0.35,
                      height: constraints.maxWidth * 0.35,
                      child: LottieBuilder.asset(
                        'assets/animations/location_icon.json',
                        fit: BoxFit.contain,
                      ),
                    )
                    .animate(key: ValueKey(content.title))
                    .slideX(
                      begin: 1.2, // Float in farther from right
                      end: 0,
                      duration: 800.ms,
                      delay: 150.ms,
                      curve: Curves.easeOutCirc,
                    )
                    .fadeIn(duration: 500.ms)
                    .then(delay: 200.ms),
              ),

              // Animation at top-right
              Positioned(
                top: -animationSize * 0.1,
                right: -animationSize * 0.1,
                child: SizedBox(
                      width: constraints.maxWidth * 0.32,
                      height: constraints.maxWidth * 0.32,
                      child: LottieBuilder.asset(
                        'assets/animations/globe.json',
                        fit: BoxFit.contain,
                      ),
                    )
                    .animate(key: ValueKey(content.title))
                    .slideX(
                      begin: 1.2, // Float in farther from right
                      end: 0,
                      duration: 800.ms,
                      delay: 150.ms,
                      curve: Curves.easeOutCirc,
                    )
                    .fadeIn(duration: 500.ms)
                    .then(delay: 200.ms),
              ),

              // Animation at bottom-right
              Positioned(
                bottom: 0,
                right: -animationSize * 0.08,
                child: SizedBox(
                      width: constraints.maxWidth * 0.35,
                      height: constraints.maxWidth * 0.35,
                      child: LottieBuilder.asset(
                        'assets/animations/menu.json',
                        fit: BoxFit.contain,
                      ),
                    )
                    .animate(key: ValueKey(content.title))
                    .slideX(
                      begin: 1.2, // Float in farther from right
                      end: 0,
                      duration: 800.ms,
                      delay: 150.ms,
                      curve: Curves.easeOutCirc,
                    )
                    .fadeIn(duration: 500.ms)
                    .then(delay: 200.ms),
              ),

              // Text chips with better positioning and rotation
              Positioned(
                top: animationSize * 0.1,
                left: animationSize * 0.05,
                child: Transform.rotate(
                  angle: -0.2,
                  child: textChips(context, 'Travel', Colors.white70),
                ),
              ),

              Positioned(
                right: -animationSize * 0.05,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Transform.rotate(
                    angle: 0.2,
                    child: textChips(context, 'Explore', Colors.white),
                  ),
                ),
              ),

              Positioned(
                bottom: animationSize * 0.15,
                left: animationSize * 0.05,
                child: Transform.rotate(
                  angle: 0.1,
                  child: textChips(context, 'Adventure', Colors.white),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 15),
        DotIndicator(currentIndex: currentIndex, length: length),
        const SizedBox(height: 10),
        _buildTextContent(context),
      ],
    );
  }

  Widget textChips(BuildContext context, String text, Color textColor) {
    var theme = Theme.of(context);
    return Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withAlpha(255),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(50),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            text,
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.surface,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
        )
        .animate(key: ValueKey(content.title))
        .slideX(
          begin: 1.2, // Float in farther from right
          end: 0,
          duration: 800.ms,
          delay: 150.ms,
          curve: Curves.easeOutCirc,
        )
        .fadeIn(duration: 500.ms)
        .then(delay: 200.ms);
  }

  Widget _buildTextContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
            key: ValueKey<String>(content.title),
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                content.title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                content.description,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ],
          )
          .animate(key: ValueKey(content.title))
          .slideX(
            begin: 1.2, // Float in farther from right
            end: 0,
            duration: 800.ms,
            delay: 150.ms,
            curve: Curves.easeOutCirc,
          )
          .fadeIn(duration: 500.ms)
          .then(delay: 200.ms),
    );
  }
}
