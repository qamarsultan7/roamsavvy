import 'package:flutter/material.dart';
import 'package:roamsavvy/featured/detailspage/view/details_view.dart';
import 'package:roamsavvy/featured/home/view/home_screen.dart';
import 'package:roamsavvy/featured/onboarding/view/onboarding_view.dart';
import 'package:roamsavvy/featured/settings/view/settings_view.dart' show SettingsView;
import 'package:roamsavvy/featured/splash/view/splash_view.dart';
import 'route_name.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      case RouteName.splash:
        return MaterialPageRoute(builder: (_) => const SplashView());

      case RouteName.onBoarding:
        return MaterialPageRoute(builder: (_) => const OnboardingView());

      case RouteName.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      
      case RouteName.settings:
        return MaterialPageRoute(builder: (_) => const SettingsView());

      case RouteName.details:
        return MaterialPageRoute(builder: (_) => const DetailsView());

      // case RouteName.medical:
      //   return MaterialPageRoute(builder: (_) => const MedicalPage());

      default:
        return _errorRoute(settings.name);
    }
  }

  static Route<dynamic> _errorRoute(String? routeName) {
    return MaterialPageRoute(
      builder:
          (_) => Scaffold(
            appBar: AppBar(title: const Text('Route Error')),
            body: Center(child: Text('No route defined for $routeName')),
          ),
    );
  }
}
