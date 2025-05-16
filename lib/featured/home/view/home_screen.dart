import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:roamsavvy/core/services/bloc/services_bloc.dart';
import 'package:roamsavvy/featured/home/view/home_view.dart';
import 'package:roamsavvy/featured/search/view/search_view.dart';
import 'package:roamsavvy/shared/bloc/bottom_nav_bar_bloc.dart';
import '../../../shared/components/share_widgets.dart';
import 'widgets/location_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ServicesBloc _servicesBloc;
  @override
  void initState() {
    _servicesBloc = context.read<ServicesBloc>();
    _servicesBloc.add(RequestLocationPermission());
    super.initState();
  }

  @override
  void dispose() {
    _servicesBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: _buildAppBar(context),
      body: BlocBuilder<ServicesBloc, ServicesState>(
        buildWhen:
            (previous, current) =>
                previous.status != current.status ||
                previous.address != current.address,
        builder: (context, state) {
          // Directly handle different location status states
          return _buildContentBasedOnLocationStatus(context, state);
        },
      ),
      bottomNavigationBar: CustomBottomNavbar(),
    );
  }

  Widget _buildContentBasedOnLocationStatus(
    BuildContext context,
    ServicesState state,
  ) {
    final theme = Theme.of(context);
    const padding = EdgeInsets.symmetric(horizontal: 20.0);
    switch (state.status) {
      case LocationStatus.loading:
        return const Center(child: CircularProgressIndicator());

      case LocationStatus.granted:
        return _buildMainContent();

      case LocationStatus.denied:
        return Center(
          child: Padding(
            padding: padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "❌ Location permission denied.",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                CustomMainButton(
                  onPressed:
                      () => _servicesBloc.add(RequestLocationPermission()),
                  label: "Request Again",
                ),
              ],
            ),
          ),
        );

      case LocationStatus.permanentlyDenied:
        return Center(
          child: Padding(
            padding: padding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("⚠️ Permission permanently denied."),
                const SizedBox(height: 16),
                CustomMainButton(
                  onPressed: () => openAppSettings(),
                  label: "Open Settings",
                ),
              ],
            ),
          ),
        );

      case LocationStatus.error:
        log(state.errorMessage!);
        return Center(
          child: Padding(
            padding: padding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("❌ Error: ${state.errorMessage}"),
                const SizedBox(height: 16),
                CustomMainButton(
                  onPressed:
                      () => _servicesBloc.add(RequestLocationPermission()),
                  label: "Try Again",
                ),
              ],
            ),
          ),
        );

      case LocationStatus.initial:
        return Center(
          child: Padding(
            padding: padding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Give Acces To your Location"),
                const SizedBox(height: 16),
                CustomMainButton(
                  onPressed:
                      () => _servicesBloc.add(RequestLocationPermission()),
                  label: "Give Access",
                ),
              ],
            ),
          ),
        );
    }
  }

  Widget _buildMainContent() {
    return BlocBuilder<BottomNavBarBloc, BottomNavBarState>(
      buildWhen:
          (previous, current) =>
              previous.selectedIndex != current.selectedIndex,
      builder: (context, state) {
        final List<Widget> pages = [const HomeView(), const SearchView()];

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOut,
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(state.selectedIndex == 0 ? -0.2 : 0.2, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: KeyedSubtree(
            key: ValueKey<int>(state.selectedIndex),
            child: pages[state.selectedIndex],
          ),
        ).animate().fadeIn();
      },
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      titleSpacing: 5,
      leading: Padding(
        padding: const EdgeInsets.only(left: 7.0, top: 7, bottom: 7),
        child: Image.asset('assets/icons/app_icon1.png')
            .animate(delay: 100.ms)
            .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1)),
      ),
      title: _buildLocationSelector(context),
    );
  }

  Widget _buildLocationSelector(BuildContext context) {
    return BlocBuilder<ServicesBloc, ServicesState>(
      buildWhen: (previous, current) => previous.address != current.address,
      builder: (context, state) {
        // You can use state.address here if available

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () => _showLocationBottomSheet(context),
              borderRadius: BorderRadius.circular(12),
              child: Row(
                children: [
                  Text(
                    state.address?.locality ?? 'locationName',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _showLocationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const LocationBottomSheet(),
    );
  }
}
