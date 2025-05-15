import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:roamsavvy/featured/home/view/widgets/location_bottom_sheet.dart';
import 'widgets/cover_heading_widget.dart';
import 'widgets/expandable_card_container.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  void _showLocationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const LocationBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _buildAppBar(context),
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

            // Scrollable list of restaurants
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
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      titleSpacing: 5,
      leading: Padding(
        padding: const EdgeInsets.only(left: 7.0, top: 7, bottom: 7),
        child: Image.asset('assets/icons/app_icon1.png')
            .animate(delay: 100.ms)
            .scale(begin: Offset(0.8, 0.8), end: Offset(1, 1)),
      ),
      title: _buildLocationSelector(context),
    );
  }

  Widget _buildLocationSelector(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () => _showLocationBottomSheet(context),
          borderRadius: BorderRadius.circular(12),
          child: Row(
            children: [
              Text(
                'New York',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
      ],
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
