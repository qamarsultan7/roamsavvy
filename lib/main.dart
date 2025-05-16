import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roamsavvy/app/app.dart';
import 'package:roamsavvy/data/network/network_api_services.dart';
import 'package:roamsavvy/featured/home/bloc/home_bloc.dart';

void main() {
  
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          // Create a new instance using proper dependency injection
          create: (context) => HomeBloc(NetworkApiServicce()),
        ),
        // Add other BlocProviders here if needed
      ],
      child: const MyApp(),
    ),
  );
}
