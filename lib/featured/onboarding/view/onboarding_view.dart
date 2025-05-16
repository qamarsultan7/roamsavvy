import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/routes/route_name.dart';
import '../widget/onboarding_page.dart';
import '../../../shared/components/custom_main_button.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_event.dart';
import '../bloc/onboarding_state.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_pageControllerListener);
  }

  @override
  void dispose() {
    _pageController.removeListener(_pageControllerListener);
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextPage(OnboardingBloc bloc, int currentIndex) {
    if (currentIndex < bloc.contents.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      bloc.add(OnboardingCompleted());
    }
  }

  void _pageControllerListener() {
    final bloc = context.read<OnboardingBloc>();
    final offset = _pageController.page ?? 0.0;
    bloc.add(OnboardingPageOffsetChanged(offset));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingBloc, OnboardingState>(
      listener: (context, state) {
        if (state.isCompleted) {
          debugPrint('Onboarding completed, navigating to next screen');
          Navigator.pushNamed(context, RouteName.home);
        }
      },
      builder: (context, state) {
        final bloc = context.read<OnboardingBloc>();
        return Scaffold(
          body: LayoutBuilder(
            builder: (context, constraints) {
              return Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: constraints.maxHeight * .8,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: bloc.contents.length,
                            physics: NeverScrollableScrollPhysics(),
                            onPageChanged: (index) {
                              bloc.add(OnboardingPageChanged(index));
                            },
                            itemBuilder: (context, index) {
                              return OnboardingPage(
                                content: bloc.contents[index],
                                constraints: constraints,
                                currentIndex: index,
                                length: bloc.contents.length,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: CustomMainButton(
                        label:
                            state.currentPageIndex == bloc.contents.length - 1
                                ? "Get Started"
                                : "Next",
                        onPressed:
                            () => _goToNextPage(bloc, state.currentPageIndex),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
