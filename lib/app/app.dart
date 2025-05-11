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
      initialRoute: RouteName.onBoarding,
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      // filepath: d:\Develop\Google APAC\roamsavvy\lib\app\app.dart
      builder: (context, child) {
        // Detect screen size
        final screenWidth = MediaQuery.of(context).size.width;
        final bool isLargeScreen = screenWidth > 600;

        return Center(
          child: Container(
            // Optional side padding for tablet/desktop views
            padding: EdgeInsets.symmetric(horizontal: isLargeScreen ? 16.0 : 0),
            decoration:
                isLargeScreen
                    ? BoxDecoration(
                      // Add subtle border or shadow on larger screens
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    )
                    : null,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 450),
              child: child!,
            ),
          ),
        );
      },
    );
  }
}
