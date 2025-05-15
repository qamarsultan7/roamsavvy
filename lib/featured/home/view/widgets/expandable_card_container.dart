import 'package:flutter/material.dart';
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

class _ExpandableRestaurantCardState extends State<ExpandableRestaurantCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.animateTo(1.0, curve: Curves.easeOutQuad);
      } else {
        _controller.animateTo(0.0, curve: Curves.easeInQuad);
      }
    });
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
        shadowColor: Theme.of(context).colorScheme.onSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias,
        child: GestureDetector(
          onTap: _toggleExpanded,
          child: Column(
            children: [
              RestaurantCardCollapsed(
                imageUrl: widget.imageUrl,
                name: widget.name,
                cuisine: widget.cuisine,
                isOpen: widget.isOpen,
                isExpanded: _isExpanded,
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
                          rating: widget.rating,
                          address: widget.address,
                          priceLevel: widget.priceLevel,
                          deliveryTime: widget.deliveryTime,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
