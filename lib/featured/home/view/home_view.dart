import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roamsavvy/featured/home/bloc/home_bloc.dart';
import 'package:roamsavvy/featured/home/view/widgets/location_bottom_sheet.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
    return BlocProvider(
      create: (context) => LocationBloc()..add(LoadCurrentLocation()),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: BlocBuilder<LocationBloc, LocationState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () => _showLocationBottomSheet(context),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.location_on, size: 18),
                    const SizedBox(width: 4),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Current Location',
                          style: TextStyle(fontSize: 14),
                        ),
                        Row(
                          children: [
                            Text(
                              state is LocationLoaded 
                                ? state.currentLocation.name 
                                : 'Loading...',
                              style: const TextStyle(fontSize: 12),
                            ),
                            const Icon(Icons.arrow_drop_down, size: 16),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          centerTitle: true,
        ),
        body: Column(children: []),
      ),
    );
  }
}
