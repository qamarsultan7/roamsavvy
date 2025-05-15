import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/home_bloc.dart';

class CoverHeadingWidget extends StatelessWidget {
  const CoverHeadingWidget({super.key, required this.size});
  final Size size;
  final List<Map<String, String>> headingData = const [
    {
      'heading': 'Enjoy Your Travel',
      'subheading':
          'Discover new places, create memories and travel with confidence',
    },
    {
      'heading': 'Explore New Places',
      'subheading':
          'Find hidden gems and popular destinations around the world',
    },
    {
      'heading': 'Travel With Ease',
      'subheading':
          'Let us handle your travel plans for a stress-free experience',
    },
    {
      'heading': 'Create Memories',
      'subheading': 'Make every journey an unforgettable adventure',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final currentIndex = state.currentHeadingIndex;

        return Container(
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/images/bg.jpeg'),
              fit: BoxFit.cover,
            ),
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12),
          ),
          height: size.height * .2,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.5, 0.8],
                  colors: [
                    Colors.black.withAlpha(150),
                    Colors.black.withAlpha(100),
                  ],
                ),
              ),
              child: OverflowBox(
                maxHeight: size.height * 0.4,
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 0),
                        child: Text(
                              headingData[currentIndex]['heading']!,
                              key: ValueKey<String>(
                                headingData[currentIndex]['heading']!,
                              ),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            )
                            .animate(
                              key: ValueKey<int>(currentIndex),
                              autoPlay: true,
                            )
                            .slideY(
                              begin: 3.0,
                              end: 0.0,
                              duration: const Duration(milliseconds: 1000),
                              curve: Curves.ease,
                            )
                            .then(
                              delay: const Duration(milliseconds: 4500),
                            ) // Increased from 2500ms
                            .slideY(
                              begin: 0.0,
                              end: -3.0,
                              duration: const Duration(milliseconds: 1000),
                              curve: Curves.ease,
                            ),
                      ),

                      const SizedBox(height: 8),

                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 0),
                        child: Text(
                              headingData[currentIndex]['subheading']!,
                              key: ValueKey<String>(
                                headingData[currentIndex]['subheading']!,
                              ),
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 14,
                              ),
                            )
                            .animate(
                              key: ValueKey<int>(currentIndex),
                              autoPlay: true,
                            )
                            .slideY(
                              begin: 3.0,
                              end: 0.0,
                              duration: const Duration(milliseconds: 1000),
                              delay: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            )
                            .then(
                              delay: const Duration(milliseconds: 4200),
                            ) // Increased from 2200ms
                            .slideY(
                              begin: 0.0,
                              end: -3.0,
                              duration: const Duration(milliseconds: 1000),
                              curve: Curves.ease,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
