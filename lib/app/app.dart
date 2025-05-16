import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roamsavvy/app/app_theme.dart';
import 'package:roamsavvy/app/routes/route_generator.dart';
import 'package:roamsavvy/app/routes/route_name.dart';
import 'package:roamsavvy/featured/settings/bloc/settings_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      buildWhen: (previous, current) => 
          previous.themeMode != current.themeMode,
      builder: (context, state) {
        return MaterialApp(
          title: 'Traveler Guide',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: state.themeMode,
          initialRoute: RouteName.home,
          onGenerateRoute: RouteGenerator.generateRoute,
          debugShowCheckedModeBanner: false,
          builder: (context, child) {
            final screenWidth = MediaQuery.of(context).size.width;
            final bool isLargeScreen =
                screenWidth >
                600; // for Now just Wanted it to make for Only Mobile Screen Width
            return Center(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isLargeScreen ? 16.0 : 0,
                ),
                decoration:
                    isLargeScreen
                        ? BoxDecoration(
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
      },
    );
  }
}
