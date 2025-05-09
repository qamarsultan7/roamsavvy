import 'package:flutter/material.dart';
import 'route_name.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      // case RouteName.home:
      //   return MaterialPageRoute(builder: (_) => const HomePage());

      // case RouteName.food:
      //   return MaterialPageRoute(builder: (_) => const FoodPage());

      // case RouteName.medical:
      //   return MaterialPageRoute(builder: (_) => const MedicalPage());

      default:
        return _errorRoute(settings.name);
    }
  }

  static Route<dynamic> _errorRoute(String? routeName) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Route Error')),
        body: Center(
          child: Text('No route defined for $routeName'),
        ),
      ),
    );
  }
}
