import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../shared/components/share_widgets.dart';
import 'widgets/widgets.dart';

class DetailsView extends StatelessWidget {
  final String imageUrl;
  final String name;
  final double rating;
  final String cuisine;
  final String address;
  final bool isOpen;
  final int priceLevel;
  final int deliveryTime;

  const DetailsView({
    super.key,
    this.imageUrl = 'assets/images/image_not_available.jpeg',
    this.name = 'Restaurant Name',
    this.rating = 4.0,
    this.cuisine = 'Cuisine Type',
    this.address = 'Restaurant Address',
    this.isOpen = true,
    this.priceLevel = 2,
    this.deliveryTime = 20,
  });

  String _getPriceString() => '\$' * priceLevel;

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
                    name,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset('assets/images/1.jpg', fit: BoxFit.cover),
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
                            cuisine,
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ).animate().fadeIn(duration: 400.ms).slideX(),
                          Text(
                            '~30 mins away',
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
                                rating.toString(),
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
                          IsOpenOrClosedWidegt(isOpen: isOpen),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  MainFeaturesSection(
                    features: const [
                      'Veg',
                      'Meal',
                      'Halal',
                      'Cafe',
                      'Bakery',
                      'Breakfast',
                      'Outdoor Seating',
                      'WiFi',
                    ],
                  ),
                  InfoSection(
                    title: 'Location',
                    icon: Icons.location_on,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(address, style: theme.textTheme.bodyLarge),
                    ),
                  ),
                  InfoSection(
                    title: 'Delivery Information',
                    icon: Icons.delivery_dining,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Estimated delivery time: $deliveryTime minutes',
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                  ),
                  InfoSection(
                    title: 'Opening Hours',
                    icon: Icons.access_time,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        TimeRow('Monday - Friday', '9:00 AM - 10:00 PM'),
                        TimeRow('Saturday', '10:00 AM - 11:00 PM'),
                        TimeRow('Sunday', '10:00 AM - 9:00 PM'),
                      ],
                    ),
                  ),
                  InfoSection(
                    title: 'Popular Items',
                    icon: Icons.restaurant_menu,
                    child: Column(
                      children: [
                        MenuItemCard(
                          name: 'Signature Burger',
                          price: '9.99',
                          description:
                              'Juicy beef patty with cheese and special sauce',
                        ),
                        MenuItemCard(
                          name: 'Deluxe Pizza',
                          price: '14.99',
                          description:
                              'Topped with pepperoni, mushrooms and olives',
                        ),
                        MenuItemCard(
                          name: 'House Salad',
                          price: '7.99',
                          description: 'Fresh greens with house dressing',
                        ),
                        seeAll(theme, 'See All'),
                      ],
                    ),
                  ),
                  // --- AI Summary Section ---
                  InfoSection(
                    title: 'Review Insights',
                    icon: Icons.pie_chart,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: ReviewInsightsChart(
                        insights: {
                          'Must Try': 70,
                          'Average': 20,
                          'Bad Experience': 10,
                        },
                      ),
                    ),
                  ),
                  const AISummarySection(),
                  InfoSection(
                    title: 'User Reviews',
                    icon: Icons.rate_review,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            children: [
                              Text(
                                '4.2',
                                style: theme.textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: List.generate(
                                      5,
                                      (index) => Icon(
                                        index < 4
                                            ? Icons.star
                                            : Icons.star_half,
                                        color: Colors.amber,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Avg Rating from all over the Internet',
                                    style: theme.textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        const ReviewItem(
                          name: 'John Doe',
                          rating: 5.0,
                          date: '2 days ago',
                          comment:
                              'Great food and atmosphere! The burger was juicy and perfectly cooked. Will definitely come back again.',
                        ),
                        const Divider(),
                        const ReviewItem(
                          name: 'Sarah Johnson',
                          rating: 4.0,
                          date: '1 week ago',
                          comment:
                              'Good food but service was a bit slow. The pizza is worth the wait though!',
                        ),
                        const Divider(),
                        const ReviewItem(
                          name: 'Mike Smith',
                          rating: 4.5,
                          date: '2 weeks ago',
                          comment:
                              'Love their salads and the friendly staff. Prices are reasonable for the quality.',
                        ),
                        const SizedBox(height: 16),
                        seeAll(theme, 'See All Reviews'),
                      ],
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

  Widget seeAll(ThemeData theme, String text) {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () {},
        child: Text(
          text,
          style: TextStyle(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
