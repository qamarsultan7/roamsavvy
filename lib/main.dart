import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roamsavvy/app/app.dart';
import 'package:roamsavvy/core/services/bloc/services_bloc.dart';
import 'package:roamsavvy/data/network/network_api_services.dart';
import 'package:roamsavvy/featured/home/bloc/home_bloc.dart';
import 'package:roamsavvy/featured/onboarding/bloc/onboarding_bloc.dart';
import 'package:roamsavvy/featured/settings/bloc/settings_bloc.dart';
import 'package:roamsavvy/shared/bloc/bottom_nav_bar_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          // Create a new instance using proper dependency injection
          create:
              (context) =>
                  HomeBloc(NetworkApiServicce())..add(GetFoodPointsDataEvent()),
        ),
        BlocProvider(create: (_)=>ServicesBloc()),
        BlocProvider(create: (_) => SettingsBloc()),
        BlocProvider(create: (_)=>BottomNavBarBloc()),
        BlocProvider(create: (_) => OnboardingBloc()),
        // Add other BlocProviders here if needed
      ],
      child: const MyApp(),
    ),
  );
}
