import 'package:flutter/material.dart';

import 'custom_main_button.dart' show CustomMainButton;

class RestaurantCardExpanded extends StatelessWidget {
  final double rating;
  final String address;
  final int priceLevel;
  final int deliveryTime;

  const RestaurantCardExpanded({
    super.key,
    required this.rating,
    required this.address,
    required this.priceLevel,
    required this.deliveryTime,
  });

  String _getPriceString() {
    return '\$' * priceLevel;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rating, Price, and Delivery Time Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Rating
              Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        rating.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Rating',
                    style: TextStyle(
                      color: theme.colorScheme.onSurface,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),

              // Price Level
              Column(
                children: [
                  Text(
                    _getPriceString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Price Range',
                    style: TextStyle(
                      color: theme.colorScheme.onSurface,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),

              // Delivery Time
              Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: theme.colorScheme.primary,
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$deliveryTime min',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text('Delivery', style: theme.textTheme.bodySmall),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Icon(
                Icons.location_on,
                color: theme.colorScheme.primary,
                size: 16,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(address, style: const TextStyle(fontSize: 14)),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // See More Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: CustomMainButton(label: 'See More', onPressed: () {}),
          ),
        ],
      ),
    );
  }
}
