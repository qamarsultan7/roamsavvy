// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roamsavvy/featured/home/bloc/home_bloc.dart';
import 'package:roamsavvy/shared/components/custom_main_button.dart';
import 'package:roamsavvy/shared/components/custom_search_field.dart';

class LocationBottomSheet extends StatefulWidget {
  const LocationBottomSheet({super.key});

  @override
  State<LocationBottomSheet> createState() => _LocationBottomSheetState();
}

class _LocationBottomSheetState extends State<LocationBottomSheet> {
  late final DraggableScrollableController _sheetController;
  late final TextEditingController _locationController;
  final FocusNode _focusNode = FocusNode();

  // Example current location
  final String _currentLocation = "123 Main Street, NY";

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _setupFocusListener();
  }

  void _initializeControllers() {
    _sheetController = DraggableScrollableController();
    _locationController = TextEditingController();
  }

  void _setupFocusListener() {
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      _expandSheet();
    }
  }

  void _expandSheet() {
    _sheetController.animateTo(
      0.9,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _sheetController.dispose();
    _locationController.dispose();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: _sheetController,
      initialChildSize: 0.25,
      maxChildSize: 0.9,
      minChildSize: 0.2,
      expand: false,
      snap: true,
      snapSizes: const [0.25, 0.9],
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(50)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            controller: scrollController,
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              _buildLocationWidget(),
              const SizedBox(height: 20),
              CustomMainButton(label: 'Use Current Location', onPressed: () {}),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLocationWidget() {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => previous.isEditing != current.isEditing,
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            if (!state.isEditing) {
              _expandSheet();
              context.read<HomeBloc>().add(ToggleIsEditingEvent());
              // Request focus after a short delay to ensure the animation and state change have started
              Future.microtask(() => _focusNode.requestFocus());
            }
          },
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child:
                state.isEditing
                    ? CustomSearchField(
                        key: const ValueKey('textField'),
                        controller: _locationController,
                        focusNode: _focusNode,
                        hintText: "Enter location...",
                        prefixIcon: const Icon(Icons.location_on),
                        onSubmitted: (value) {
                          _focusNode.unfocus();
                          final homeBloc = context.read<HomeBloc>();
                          homeBloc.add(ToggleIsEditingEvent());
                          // Handle submission and toggle editing state
                          if (value.isNotEmpty) {
                            // Add your location saving logic here
                          }
                        },
                        onClear: () {
                          // Additional clear behavior if needed
                        },
                      )
                    : Container(
                      key: const ValueKey('locationDisplay'),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withAlpha(50),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Color(0xFF0F4C81),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _currentLocation,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                    ),
          ),
        );
      },
    );
  }
}
