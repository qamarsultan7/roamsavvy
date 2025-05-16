import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roamsavvy/app/app.dart';
import 'package:roamsavvy/core/services/bloc/services_bloc.dart';
import 'package:roamsavvy/featured/home/bloc/home_bloc.dart';
import 'package:roamsavvy/featured/onboarding/bloc/onboarding_bloc.dart';
import 'featured/settings/bloc/settings_bloc.dart';
import 'shared/bloc/bottom_nav_bar_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => OnboardingBloc()),
        BlocProvider(create: (_) => HomeBloc()),
        BlocProvider(create: (_) => BottomNavBarBloc()),
        BlocProvider(create: (_) => SettingsBloc()),
        BlocProvider(
          create: (_) => ServicesBloc()..add(RequestLocationPermission()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
