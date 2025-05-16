import 'package:flutter/material.dart';
import 'package:roamsavvy/featured/home/models/food_points_data_model.dart';

import 'share_widgets.dart';

class RestaurantCardCollapsed extends StatelessWidget {
  final FoodPointsDataModel restaurant;
  final bool isExpanded;

  const RestaurantCardCollapsed({
    super.key,
    required this.restaurant,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(restaurant.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black.withAlpha(150), Colors.black.withAlpha(100)],
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurant.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          shadows: [
                            Shadow(
                              blurRadius: 3.0,
                              color: Colors.black,
                              offset: Offset(1.0, 1.0),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        restaurant.cuisine,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          shadows: [
                            Shadow(
                              blurRadius: 2.0,
                              color: Colors.black,
                              offset: Offset(0.5, 0.5),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                IsOpenOrClosedWidegt(isOpen: restaurant.isOpen),
              ],
            ),
            const SizedBox(height: 4),
            Center(
              child: Icon(
                isExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
