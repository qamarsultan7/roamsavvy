import 'package:flutter/material.dart';
import 'package:roamsavvy/featured/detailspage/view/details_view.dart';
import 'package:roamsavvy/featured/home/models/food_points_data_model.dart';
import 'custom_main_button.dart' show CustomMainButton;

class RestaurantCardExpanded extends StatelessWidget {
  final FoodPointsDataModel restaurant;

  const RestaurantCardExpanded({
    super.key,
    required this.restaurant,
  });

  String _getPriceString() {
    return '\$' * restaurant.priceLevel;
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
                        restaurant.rating.toString(),
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
                        '${restaurant.deliveryTime} min',
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
                child: Text(restaurant.address, style: const TextStyle(fontSize: 14)),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // See More Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: CustomMainButton(
              label: 'See More',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailsView(
                    restaurant: restaurant,
                  ),
                ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
