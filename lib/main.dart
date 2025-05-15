import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roamsavvy/app/app.dart';
import 'package:roamsavvy/featured/home/bloc/home_bloc.dart';
import 'package:roamsavvy/featured/onboarding/bloc/onboarding_bloc.dart';
import 'shared/bloc/bottom_nav_bar_bloc.dart';


void main() {
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (context) => OnboardingBloc()),
      BlocProvider(create: (_)=>HomeBloc()),
      BlocProvider(
        create: (_) => BottomNavBarBloc(),
      ),
      ],
      child: const MyApp(),
    ),
  );
}
