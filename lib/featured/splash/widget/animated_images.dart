
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Widget responsible for displaying and animating the app logo and text

/// Grid of animated travel images
class AnimatedImagesGrid extends StatelessWidget {
  final List<Offset> randomPositions;
  final math.Random random;

  const AnimatedImagesGrid({
    super.key,
    required this.randomPositions,
    required this.random,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: List.generate(
        13,
        (index) => AnimatedImageItem(
          index: index,
          position: randomPositions[index],
          random: random,
        ),
      ),
    );
  }
}

/// Single animated image item
class AnimatedImageItem extends StatelessWidget {
  final int index;
  final Offset position;
  final math.Random random;

  const AnimatedImageItem({
    super.key,
    required this.index,
    required this.position,
    required this.random,
  });

  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.blue,
      Colors.purple,
      Colors.pink,
      Colors.orange,
      Colors.teal,
      Colors.indigo,
    ];

    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Image.asset(
            'assets/images/${index + 1}.jpg',
            width: 90 + random.nextInt(150).toDouble(),
            height: 90 + random.nextInt(150).toDouble(),
            fit: BoxFit.cover,
          )
          .animate(delay: Duration(milliseconds: 500 + index * 250))
          // Apply blur and rounded corners
          .custom(
            builder:
                (context, value, child) => ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: child,
                ),
          )
          // More dramatic entrance with blur effect
          .custom(
            begin: 1.0,
            end: 0.0,
            duration: const Duration(milliseconds: 800),
            builder:
                (context, value, child) => ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaX: 10 * value,
                    sigmaY: 10 * value,
                  ),
                  child: child,
                ),
          )
          .slideY(
            begin: 0.3,
            end: 0,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOutQuint,
          )
          .fadeIn(duration: const Duration(milliseconds: 700))
          // Enhanced shadow with color tint based on image index
          .custom(
            builder: (context, value, child) {
              return Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: colors[index % colors.length].withAlpha(
                        (255 * 0.4).toInt(),
                      ),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: child,
              );
            },
          )
          // More interesting hover movement
          .then()
          .moveX(
            begin: 0,
            end: -20 + random.nextInt(40).toDouble(),
            duration: const Duration(milliseconds: 3500),
            curve: Curves.easeInOutSine,
          )
          .moveY(
            begin: 0,
            end: -20 + random.nextInt(40).toDouble(),
            duration: const Duration(milliseconds: 3500),
            curve: Curves.easeInOutSine,
          )
          .scale(
            begin: const Offset(1, 1),
            end: const Offset(1.2, 1.2),
            duration: const Duration(milliseconds: 3500),
          )
          // Add a flip effect for more visual interest
          .then(delay: const Duration(milliseconds: 1000))
          // More dramatic exit - "fly past" camera effect
          .custom(
            begin: 0.0,
            end: 1.0,
            duration: const Duration(milliseconds: 400),
            builder:
                (context, value, child) => ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaX: (20 * value).toDouble(), // stronger blur
                    sigmaY: (20 * value).toDouble(),
                  ),
                  child: child,
                ),
          )
          .scaleXY(
            begin: 1.2,
            end: 2.5, // much larger scale to simulate "passing through"
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeIn, // accelerate out
          )
          // Add z-translation effect
          .moveY(
            begin: 0,
            end: index % 2 == 0 ? 200 : -200, // move off screen
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeIn,
          )
          .moveX(
            begin: 0,
            end:
                index % 3 == 0
                    ? 100
                    : (index % 3 == 1 ? -100 : 0), // some left, some right
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeIn,
          )
          .fadeOut(duration: const Duration(milliseconds: 400)),
    );
  }
}
