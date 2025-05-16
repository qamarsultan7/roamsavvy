import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roamsavvy/featured/home/bloc/home_bloc.dart';
import 'package:roamsavvy/featured/home/models/food_points_data_model.dart';
import 'collapsed_card_widget.dart';
import 'expanded_card_widget.dart';

class ExpandableRestaurantCard extends StatefulWidget {
  final FoodPointsDataModel foodPointsDataModel;
  const ExpandableRestaurantCard({
    super.key,
    required this.foodPointsDataModel,
  });

  @override
  State<ExpandableRestaurantCard> createState() =>
      _ExpandableRestaurantCardState();
}

class _ExpandableRestaurantCardState extends State<ExpandableRestaurantCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  void _toggleExpanded(BuildContext context) {
    final isExpanded = context.read<HomeBloc>().state.isExpanded;
    context.read<HomeBloc>().add(ToggleExpandedWidget());

    if (!isExpanded) {
      _controller.animateTo(1.0, curve: Curves.easeOutQuad);
    } else {
      _controller.animateTo(0.0, curve: Curves.easeInQuad);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias,
        child: BlocBuilder<HomeBloc, HomeState>(
          buildWhen:
              (previous, current) => previous.isExpanded != current.isExpanded,
          builder: (context, state) {
            // Sync local state with bloc state
            return GestureDetector(
              onTap: () => _toggleExpanded(context),
              child: Column(
                children: [
                  RestaurantCardCollapsed(
                    restaurant: widget.foodPointsDataModel,
                    isExpanded: state.isExpanded,
                  ),
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return ClipRect(
                        child: Align(
                          heightFactor: _controller.value,
                          child: Opacity(
                            opacity: _controller.value,
                            child: RestaurantCardExpanded(
                              restaurant: widget.foodPointsDataModel,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
