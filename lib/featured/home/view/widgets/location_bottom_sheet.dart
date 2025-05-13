import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roamsavvy/featured/home/bloc/home_bloc.dart';

class LocationBottomSheet extends StatefulWidget {
  const LocationBottomSheet({super.key});

  @override
  State<LocationBottomSheet> createState() => _LocationBottomSheetState();
}

class _LocationBottomSheetState extends State<LocationBottomSheet> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.2,
      maxChildSize: 0.9,
      minChildSize: 0.2,
      expand: false,
      builder: (context, scrollController) {
        _scrollController.addListener(() {
          scrollController.position.correctBy(_scrollController.position.pixels - scrollController.position.pixels);
        });
        
        return BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
            return SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Location Details',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    
                    if (state is LocationLoaded) ...[
                      ListTile(
                        leading: const Icon(Icons.location_on),
                        title: const Text('Current Location'),
                        subtitle: Text(state.currentLocation.address),
                        onTap: _scrollToTop,
                      ),
                      const SizedBox(height: 10),
                      
                      ...state.savedLocations.map((location) => 
                        ListTile(
                          leading: const Icon(Icons.star),
                          title: Text(location.name),
                          subtitle: Text(location.address),
                          onTap: () {
                            context.read<LocationBloc>().add(SelectLocation(location));
                            _scrollToTop();
                            Navigator.pop(context);
                          },
                        )
                      ),
                    ] else ...[
                      const ListTile(
                        leading: Icon(Icons.location_on),
                        title: Text('Loading locations...'),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
