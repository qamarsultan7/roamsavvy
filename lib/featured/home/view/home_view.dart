import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/cover_heading_widget.dart';
import '../../../shared/components/expandable_card_container.dart';
import '../bloc/home_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
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

            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final restaurant = state.restaurants[index];
                    return ExpandableRestaurantCard(
                          foodPointsDataModel: restaurant,
                        )
                        .animate(delay: ((index + 1) * 50).ms)
                        .scale(
                          begin: const Offset(0.8, 0.8),
                          end: const Offset(1, 1),
                        );
                  }, childCount: state.restaurants.length),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

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
