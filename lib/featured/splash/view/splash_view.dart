import 'package:flutter/material.dart';
import 'package:roamsavvy/featured/splash/widget/animated_images.dart';
import 'dart:math' as math;

import 'package:roamsavvy/featured/splash/widget/app_brand_widget.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    // Generate random positions for images
    final random = math.Random();
    List<Offset> randomPositions = _generateRandomPositions(screenSize, random);

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          // 1. Animated images (background elements)
          // 2. App branding (foreground elements)
          const AppBrandingWidget(),
          AnimatedImagesGrid(randomPositions: randomPositions, random: random),
        ],
      ),
    );
  }

  List<Offset> _generateRandomPositions(Size screenSize, math.Random random) {
    List<Offset> positions = [];

    // Divide screen into a grid for better distribution
    int gridSize = 4;
    double cellWidth = screenSize.width / gridSize;
    double cellHeight = screenSize.height / gridSize;

    for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j < gridSize; j++) {
        double x = (i * cellWidth) + random.nextDouble() * (cellWidth - 100);
        double y = (j * cellHeight) + random.nextDouble() * (cellHeight - 100);
        positions.add(Offset(x, y));
      }
    }

    // Add a few more random positions
    for (int i = 0; i < 5; i++) {
      positions.add(
        Offset(
          random.nextDouble() * (screenSize.width - 150),
          random.nextDouble() * (screenSize.height - 150),
        ),
      );
    }

    return positions;
  }
}
