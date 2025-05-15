import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:roamsavvy/featured/home/view/widgets/expanded_items_card.dart';
import 'package:roamsavvy/featured/home/view/widgets/location_bottom_sheet.dart';

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/images/bg.jpeg'),
                    fit: BoxFit.cover,
                  ),
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                height: size.height * .25,
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.1),
                        Colors.black.withOpacity(0.6),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'data',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
          
              ExpandableRestaurantCard(
                imageUrl: 'assets/images/bg.jpeg',
                name: 'McDonald\'s',
                rating: 4.2,
                cuisine: 'Fast Food',
                address: '123 Main Street, New York',
                isOpen: true,
                priceLevel: 1,
                deliveryTime: 15,
              ),
            ],
          ),
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
