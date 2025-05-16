import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../shared/components/share_widgets.dart';
import 'widgets/widgets.dart';
import '../../home/models/food_points_data_model.dart';

class DetailsView extends StatelessWidget {
  final FoodPointsDataModel restaurant;

  const DetailsView({super.key, required this.restaurant});

  String _getPriceString() => '\$' * restaurant.priceLevel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                expandedHeight: size.height * 0.3,
                pinned: true,
                backgroundColor: theme.colorScheme.primary,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  centerTitle: true,
                  title: Text(
                    restaurant.name,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(restaurant.imageUrl, fit: BoxFit.cover),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              theme.colorScheme.primary.withAlpha(100),
                              theme.colorScheme.primary.withAlpha(190),
                            ],
                            stops: const [0.4, 0.75, 1.0],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            restaurant.cuisine,
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ).animate().fadeIn(duration: 400.ms).slideX(),
                          Text(
                            '~${restaurant.deliveryTime} mins away',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ).animate().fadeIn(duration: 400.ms).slideX(),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber),
                              const SizedBox(width: 4),
                              Text(
                                restaurant.rating.toString(),
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            _getPriceString(),
                            style: theme.textTheme.titleMedium,
                          ),
                          IsOpenOrClosedWidegt(isOpen: restaurant.isOpen),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  MainFeaturesSection(features: restaurant.features),
                  InfoSection(
                    title: 'Location',
                    icon: Icons.location_on,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        restaurant.address,
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                  ),
                  InfoSection(
                    title: 'Delivery Information',
                    icon: Icons.delivery_dining,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Estimated delivery time: ${restaurant.deliveryTime} minutes',
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                  ),
                  InfoSection(
                    title: 'Opening Hours',
                    icon: Icons.access_time,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          restaurant.openingHours
                              .map((hours) => TimeRow(hours.day, hours.time))
                              .toList(),
                    ),
                  ),
                  InfoSection(
                    title: 'Popular Items',
                    icon: Icons.restaurant_menu,
                    child: Column(
                      children:
                          restaurant.popularItems
                              .map(
                                (item) => MenuItemCard(
                                  name: item.name,
                                  price: item.price,
                                  description: item.description,
                                ),
                              )
                              .toList(),
                    ),
                  ),
                  InfoSection(
                    title: 'Review Insights',
                    icon: Icons.pie_chart,
                    child: ReviewInsightsChart(
                      insights: restaurant.reviewInsights,
                    ),
                  ),
                  InfoSection(
                    title: 'User Reviews',
                    icon: Icons.rate_review,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          restaurant.userReviews
                              .map(
                                (review) => ReviewItem(
                                  name: review.name,
                                  rating: review.rating,
                                  date: review.date,
                                  comment: review.comment,
                                ),
                              )
                              .toList(),
                    ),
                  ),
                  const SizedBox(height: 30),
                ]),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * .1,
                vertical: 8,
              ),
              child:
                  CustomMainButton(
                    label: 'Navigate to location',
                    onPressed: () {},
                  ).animate().fadeIn(duration: 400.ms).slideY(),
            ),
          ),
        ],
      ),
    );
  }
}
