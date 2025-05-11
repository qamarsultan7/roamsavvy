import 'package:flutter/material.dart';

import '../models/onboarding_content.dart';
import '../widget/onboarding_page.dart';
import '../widget/dot_indicator.dart';
import '../widget/next_button.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  final List<OnboardingContent> _contents = [
    OnboardingContent(
      title: "Discover New Places",
      description: "Find amazing destinations around the world with just a few taps.",
      animationPath: "assets/animations/drink.json",
    ),
    OnboardingContent(
      title: "Plan Your Journey",
      description: "Create personalized travel itineraries and stay organized.",
      animationPath: "assets/animations/drink.json",
    ),
    OnboardingContent(
      title: "Travel Like a Local",
      description: "Get insider tips and recommendations for an authentic experience.",
      animationPath: "assets/animations/drink.json",
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextPage() {
    if (_currentPageIndex < _contents.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to the next screen after onboarding
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                // Skip button
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextButton(
                      onPressed: () {
                        // Navigate to the next screen
                      },
                      child: const Text("Skip"),
                    ),
                  ),
                ),
                
                // PageView for onboarding content
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _contents.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPageIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return OnboardingPage(
                        content: _contents[index],
                        constraints: constraints,
                      );
                    },
                  ),
                ),
                
                // Dot indicators and next button
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DotIndicator(
                        currentIndex: _currentPageIndex,
                        length: _contents.length,
                      ),
                      NextButton(
                        onPressed: _goToNextPage,
                        isLastPage: _currentPageIndex == _contents.length - 1,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}