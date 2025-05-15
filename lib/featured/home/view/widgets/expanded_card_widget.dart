import 'package:flutter/material.dart';

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
                  const Text(
                    'Rating',
                    style: TextStyle(color: Colors.black54, fontSize: 12),
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
                  const Text(
                    'Price Range',
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                ],
              ),

              // Delivery Time
              Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: Colors.black87,
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$deliveryTime min',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    'Delivery',
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Address
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.black87,
                size: 16,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  address,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // See More Button
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Navigate to detail page
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Theme.of(context).primaryColor,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text(
                'See More',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
