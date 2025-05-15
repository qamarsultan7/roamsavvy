import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roamsavvy/shared/bloc/bottom_nav_bar_bloc.dart';

class CustomBottomNavbar extends StatefulWidget {
  final Function(int)? onTap;
  final int selectedIndex;

  const CustomBottomNavbar({super.key, this.onTap, this.selectedIndex = 0});

  @override
  State<CustomBottomNavbar> createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends State<CustomBottomNavbar> {
  late List<IconData> _tabIcons;

  @override
  void initState() {
    super.initState();

    // Initialize the tab icons
    _tabIcons = [
      Icons.home_outlined,
      Icons.explore_outlined,
      Icons.person_outline,
    ];

    // Set initial BLoC state if needed
    if (widget.selectedIndex != 0) {
      context.read<BottomNavBarBloc>().add(
        BottomNavBarItemTapped(index: widget.selectedIndex)
      );
    }
  }

  void _onTabSelected(int newIndex) {
    // Dispatch event to the BLoC
    context.read<BottomNavBarBloc>().add(
      BottomNavBarItemTapped(index: newIndex)
    );

    // Call the onTap callback if provided
    widget.onTap?.call(newIndex);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBarBloc, BottomNavBarState>(
      builder: (context, state) {
        final theme = Theme.of(context);
        final borderRadius = BorderRadius.circular(12);

        // Calculate the total width based on icons and spacing
        final double tabWidth = 60.0; // Base width per tab
        final double spacing = 50.0; // Spacing between tabs
        final double totalWidth =
            (_tabIcons.length * tabWidth) +
            (((_tabIcons.length - 1) * spacing) + 10);

        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: totalWidth,
            height: 70,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: borderRadius,
            ),
            child: ClipRRect(
              borderRadius: borderRadius,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor.withAlpha(50),
                    borderRadius: borderRadius,
                    border: Border.all(
                      color: theme.primaryColor.withAlpha(100),
                      width: 2,
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Droplet background per tab
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(_tabIcons.length * 2 - 1, (index) {
                          // Add spacing widgets between tabs
                          if (index.isOdd) {
                            return SizedBox(width: spacing);
                          }

                          final tabIndex = index ~/ 2;
                          final isCurrent = tabIndex == state.selectedIndex;
                          final isOld =
                              tabIndex == state.previousIndex &&
                              state.selectedIndex != state.previousIndex;

                          if (!isCurrent && !isOld) {
                            return SizedBox(width: tabWidth);
                          }

                          final animation =
                              isCurrent
                                  ? Animate(
                                    key: ValueKey("grow-$tabIndex"),
                                    effects: [
                                      ScaleEffect(
                                        end: Offset(1, 1),
                                        begin: Offset(0, 0),
                                        duration: 300.ms,
                                      ),
                                    ],
                                    child: _buildDroplet(context),
                                  )
                                  : Animate(
                                    key: ValueKey("shrink-$tabIndex"),
                                    effects: [
                                      ScaleEffect(
                                        begin: Offset(1, 1),
                                        end: Offset(0, 0),
                                        duration: 300.ms,
                                      ),
                                    ],
                                    child: _buildDroplet(context),
                                  );

                          return SizedBox(
                            width: tabWidth,
                            child: Center(child: animation),
                          );
                        }),
                      ),

                      // Foreground icons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(_tabIcons.length * 2 - 1, (index) {
                          // Add spacing widgets between tabs
                          if (index.isOdd) {
                            return SizedBox(width: spacing);
                          }

                          final tabIndex = index ~/ 2;
                          final isSelected = tabIndex == state.selectedIndex;

                          return SizedBox(
                            width: tabWidth,
                            child: GestureDetector(
                              onTap: () => _onTabSelected(tabIndex),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Center(
                                  child: Icon(
                                    _tabIcons[tabIndex],
                                    color:
                                        isSelected
                                            ? theme.scaffoldBackgroundColor
                                            : theme.colorScheme.onSurface,
                                    size: 28,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDroplet(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withAlpha(200),
        shape: BoxShape.circle,
      ),
    );
  }
}
