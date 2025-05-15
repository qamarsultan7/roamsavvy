import 'package:flutter/material.dart';
import 'package:roamsavvy/featured/home/view/widgets/expandable_card_container.dart';
import 'collapsed_card_widget.dart';
import 'expanded_card_widget.dart';

class ExpandableRestaurantCard extends StatefulWidget {
  final String imageUrl;
  final String name;
  final double rating;
  final String cuisine;
  final String address;
  final bool isOpen;
  final int priceLevel;
  final int deliveryTime;

  const ExpandableRestaurantCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.rating,
    required this.cuisine,
    required this.address,
    required this.isOpen,
    required this.priceLevel,
    required this.deliveryTime,
  });

  @override
  State<ExpandableRestaurantCard> createState() =>
      _ExpandableRestaurantCardState();
}

class _ExpandableRestaurantCardState extends State<ExpandableRestaurantCard> {
  bool _isExpanded = false;

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableCardContainer(
      isExpanded: _isExpanded,
      onToggle: _toggleExpanded,
      collapsedChild: RestaurantCardCollapsed(
        imageUrl: widget.imageUrl,
        name: widget.name,
        cuisine: widget.cuisine,
        isOpen: widget.isOpen,
        isExpanded: _isExpanded,
      ),
      expandedChild: RestaurantCardExpanded(
        rating: widget.rating,
        address: widget.address,
        priceLevel: widget.priceLevel,
        deliveryTime: widget.deliveryTime,
      ),
    );
  }
}
