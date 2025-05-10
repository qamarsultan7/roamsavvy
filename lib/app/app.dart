import 'package:flutter/material.dart';
import 'package:roamsavvy/app/app_theme.dart';
import 'package:roamsavvy/app/routes/route_generator.dart';
import 'package:roamsavvy/app/routes/route_name.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Traveler Guide',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light, 
      initialRoute: RouteName.splash,
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
