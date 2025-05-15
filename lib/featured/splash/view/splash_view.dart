import 'dart:async';

import 'package:flutter/material.dart';
import 'package:roamsavvy/app/routes/route_name.dart';
import 'package:roamsavvy/featured/splash/widget/animated_images.dart';
import 'dart:math' as math;

import 'package:roamsavvy/featured/splash/widget/app_brand_widget.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, RouteName.onBoarding);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final random = math.Random();
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          const AppBrandingWidget(),
          AnimatedImagesGrid(random: random),
        ],
      ),
    );
  }
}
