import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roamsavvy/app/app.dart';
import 'package:roamsavvy/featured/onboarding/bloc/onboarding_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (context) => OnboardingBloc())],
      child: const MyApp(),
    ),
  );
}
