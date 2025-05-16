import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Grid of animated travel images with a ribbon layout (top and bottom)
class AnimatedImagesGrid extends StatelessWidget {
  final math.Random random;

  const AnimatedImagesGrid({
    super.key,
    required this.random,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Use fewer images for better performance
    const int totalImages = 10;
    const int topImages = 5;
    const int bottomImages = totalImages - topImages;

    return Stack(
      fit: StackFit.expand,
      children: [
        // Top ribbon of images with parallax effect
        _buildImageRibbon(
          context: context,
          start: 0,
          count: topImages,
          isTop: true,
          screenSize: size,
          parallaxSpeed: 1.2, // Slightly faster movement
        ),

        // Bottom ribbon of images with different parallax effect
        _buildImageRibbon(
          context: context,
          start: topImages,
          count: bottomImages,
          isTop: false,
          screenSize: size,
          parallaxSpeed: 0.8, // Slightly slower movement
        ),
      ],
    );
  }

  Widget _buildImageRibbon({
    required BuildContext context,
    required int start,
    required int count,
    required bool isTop,
    required Size screenSize,
    double parallaxSpeed = 1.0,
  }) {
    // Increase ribbon height for more impact
    final ribbonHeight = screenSize.height * 0.28;
    final yPosition = isTop
        ? screenSize.height * 0.02 // Slight padding from the top
        : screenSize.height - ribbonHeight - screenSize.height * 0.02; // Padding from bottom

    // More dramatic spacing for better distribution
    final spacing = screenSize.width / (count);

    return Positioned(
      top: yPosition,
      left: 0,
      right: 0,
      height: ribbonHeight,
      child: Stack(
        children: List.generate(
          count,
          (index) {
            final imageIndex = start + index;

            // More dramatic size variation based on position
            final baseSizeMultiplier = isTop ? 1.0 : 1.1; // Bottom images slightly larger
            final size = (70.0 + (imageIndex % 4) * 30.0) * baseSizeMultiplier;

            // Calculate x position with controlled randomness
            final baseX = spacing * (index + 0.5); // Center in each segment
            final xVariance = (random.nextDouble() - 0.5) * (spacing * 0.4);
            final xPos = baseX + xVariance;

            // Calculate y position with more control
            final baseY = ribbonHeight * 0.5 - size / 2;
            // Less variance for a more organized look
            final yVariance = (random.nextDouble() - 0.5) * (ribbonHeight * 0.4);
            final yPos = baseY + yVariance;

            // Travel/polaroid theme with rotations
            final rotation = (random.nextDouble() - 0.5) * 0.2; // Slight random rotation

            return AnimatedImageItem(
              index: imageIndex,
              position: Offset(xPos - size / 2, yPos),
              size: size,
              random: random,
              flipDirection: (imageIndex % 2 == 0),
              rotation: rotation,
              parallaxSpeed: parallaxSpeed,
              // Style as travel snapshots with white border
              usePolaroidStyle: true,
            );
          },
        ),
      ),
    );
  }
}

/// Single animated image item
class AnimatedImageItem extends StatelessWidget {
  final int index;
  final Offset position;
  final double size;
  final math.Random random;
  final bool flipDirection;
  final double rotation;
  final double parallaxSpeed;
  final bool usePolaroidStyle;

  const AnimatedImageItem({
    super.key,
    required this.index,
    required this.position,
    required this.size,
    required this.random,
    this.flipDirection = false,
    this.rotation = 0.0,
    this.parallaxSpeed = 1.0,
    this.usePolaroidStyle = false,
  });

  @override
  Widget build(BuildContext context) {
final color=Theme.of(context).colorScheme.secondary;
   final Widget imageWidget = usePolaroidStyle
        ? Container(
            width: size,
            height: size,
            padding: EdgeInsets.all(size * 0.05),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: color.withAlpha(80),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                'assets/images/${index + 1}.jpg',
                fit: BoxFit.cover,
              ),
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              'assets/images/${index + 1}.jpg',
              width: size,
              height: size,
              fit: BoxFit.cover,
            ),
          );

    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Transform.rotate(
        angle: rotation,
        child: imageWidget
            .animate(delay: Duration(milliseconds: 150 + index * 100))
            // Apply additional animation effects with parallax speed
            .slideX(
              begin: flipDirection ? 0.3 * parallaxSpeed : -0.3 * parallaxSpeed,
              end: 0,
              duration: Duration(milliseconds: (700 * (1 / parallaxSpeed)).toInt()),
              curve: Curves.easeOutQuint,
            )
            // ...rest of the animation chain...
      ),
    );
  }
}
