import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'dart:math' as math;

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final centerX = screenSize.width / 2;
    final centerY = screenSize.height / 2;
    final radius = screenSize.width * 0.3;

    // Random positions for images
    final random = math.Random();
    List<Offset> randomPositions = List.generate(
      13,
      (_) => Offset(
        random.nextDouble() * (screenSize.width - 100),
        random.nextDouble() * (screenSize.height - 100),
      ),
    );

    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            // STAGE 3: App icon and name animations (trigger last)
            Column(
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
                            .animate(
                              delay: const Duration(
                                seconds: 5,
                              ), // Delay until after other animations
                            )
                            .slideY(
                              begin: -0.4,
                              end: 0.8,
                              duration: const Duration(milliseconds: 800),
                              curve: Curves.easeInOut,
                            ),
                      ),

                      // App icon animation
                      Image.asset(
                            'assets/icons/app_icon1.png',
                            width: 180,
                            height: 180,
                          )
                          .animate(delay: const Duration(seconds: 5))
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
                    .animate(delay: const Duration(seconds: 6))
                    .fadeIn(duration: const Duration(milliseconds: 800)),
              ],
            ),

            // STAGE 2: Random placed images that zoom in and disappear
            ...List.generate(
              13,
              (index) => Positioned(
                left: randomPositions[index].dx,
                top: randomPositions[index].dy,
                child: Image.asset(
                  'assets/images/${index + 1}.jpg', // Assuming you have images named image1.jpg, image2.jpg, etc.
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ).animate(
                  delay: Duration(milliseconds: 1000 + index * 100),
                )
                    .scale(
                      begin: 0.0,
                      end: 1.0,
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeInOut,
                    )
                    .fadeOut(
                      begin: 1.0,
                      end: 0.0,
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeInOut,
                    ),
              ),
            ),

            // STAGE 1: Lottie animations in a circle pattern
            Positioned(
              left: centerX - 75,
              top: centerY - radius - 75,
              child: SizedBox(
                    width: 150,
                    height: 150,
                    child: LottieBuilder.asset(
                      'assets/animations/french-fries.json',
                    ),
                  )
                  .animate(delay: const Duration(milliseconds: 1000))
                  .moveY(
                    begin: 0,
                    end: -screenSize.height,
                    duration: const Duration(milliseconds: 1000),
                  ),
            ),
            Positioned(
              left: centerX + radius - 75,
              top: centerY - 75,
              child: SizedBox(
                    width: 150,
                    height: 150,
                    child: LottieBuilder.asset('assets/animations/drink.json'),
                  )
                  .animate(delay: const Duration(milliseconds: 1000))
                  .moveX(
                    begin: 0,
                    end: screenSize.width,
                    duration: const Duration(milliseconds: 1000),
                  ),
            ),
            Positioned(
              left: centerX - radius - 30,
              top: centerY - 75,
              child: SizedBox(
                    width: 150,
                    height: 150,
                    child: LottieBuilder.asset(
                      'assets/animations/food-delivery.json',
                    ),
                  )
                  .animate(delay: const Duration(milliseconds: 1000))
                  .moveX(
                    begin: 0,
                    end: -screenSize.width,
                    duration: const Duration(milliseconds: 1000),
                  ),
            ),
            Positioned(
              left: centerX - 75,
              top: centerY + radius - 75,
              child: SizedBox(
                    width: 150,
                    height: 150,
                    child: LottieBuilder.asset(
                      'assets/animations/Fast delivery.json',
                    ),
                  )
                  .animate(delay: const Duration(milliseconds: 1000))
                  .moveY(
                    begin: 0,
                    end: screenSize.height,
                    duration: const Duration(milliseconds: 1000),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
