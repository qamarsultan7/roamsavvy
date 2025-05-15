import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:roamsavvy/featured/home/view/home_view.dart';
import 'widgets/location_bottom_sheet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: IndexedStack(children: [HomeView()]),
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
            .scale(begin: Offset(0.8, 0.8), end: Offset(1, 1)),
      ),
      title: _buildLocationSelector(context),
    );
  }

  Widget _buildLocationSelector(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () => _showLocationBottomSheet(context),
          borderRadius: BorderRadius.circular(12),
          child: Row(
            children: [
              Text(
                'New York',
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
  }
}
