import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../shared/components/custom_bottom_navbar.dart';
import 'widgets/cover_heading_widget.dart';
import 'widgets/expandable_card_container.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Cover heading that scrolls away
            SliverToBoxAdapter(child: CoverHeadingWidget(size: size)),

            // Sticky header
            SliverPersistentHeader(
              pinned: true,
              delegate: _StickyHeaderDelegate(
                child: Container(
                  width: double.infinity,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Nearby Food Points',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                maxHeight: 65.0,
                minHeight: 65.0,
              ),
            ),

            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return ExpandableRestaurantCard(
                      imageUrl: 'assets/images/image_not_available.jpeg',
                      name: 'McDonald\'s',
                      rating: 4.2,
                      cuisine: 'Fast Food',
                      address: '123 Main Street, New York',
                      isOpen: true,
                      priceLevel: 1,
                      deliveryTime: 15,
                    )
                    .animate(delay: ((index + 1) * 50).ms)
                    .scale(
                      begin: const Offset(0.8, 0.8),
                      end: const Offset(1, 1),
                    );
              }, childCount: 15),
            ),
          ],
        ),
      ),

      bottomNavigationBar: CustomBottomNavbar(),
    );
  }
}

// Custom delegate for the sticky header
class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double maxHeight;
  final double minHeight;

  _StickyHeaderDelegate({
    required this.child,
    required this.maxHeight,
    required this.minHeight,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox(width: double.infinity, height: maxHeight, child: child);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant _StickyHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
