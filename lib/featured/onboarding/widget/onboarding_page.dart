import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../models/onboarding_content.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingContent content;
  final BoxConstraints constraints;

  const OnboardingPage({
    super.key,
    required this.content,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    // Responsive sizing
    final bool isLandscape = constraints.maxWidth > constraints.maxHeight;
    final double animationSize = isLandscape 
        ? constraints.maxHeight * 0.5 
        : constraints.maxWidth * 0.7;
    
    if (isLandscape) {
      // Landscape layout
      return Row(
        children: [
          Expanded(
            flex: 1,
            child: Lottie.asset(
              content.animationPath,
              width: animationSize,
              height: animationSize,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            flex: 1,
            child: _buildTextContent(context),
          ),
        ],
      );
    } else {
      // Portrait layout
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            content.animationPath,
            width: animationSize,
            height: animationSize,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 40),
          _buildTextContent(context),
        ],
      );
    }
  }

  Widget _buildTextContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
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
      ),
    );
  }
}
