import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'service_restaurant.dart';
import 'widget_restaurant_card.dart';
import 'screen_restaurant_detail.dart';

class DealsScreen extends StatelessWidget {
  const DealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final restaurantService = Provider.of<MockRestaurantService>(context);
    final deals = restaurantService.deals;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Special Deals'),
      ),
      body: deals.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.local_offer_outlined,
                size: 64, color: Colors.orange[300]),
            const SizedBox(height: 16),
            Text(
              'No deals available',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: deals.length,
        itemBuilder: (context, index) {
          final restaurant = deals[index];
          return RestaurantCard(
            restaurant: restaurant,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RestaurantDetailScreen(
                  restaurantId: restaurant.id,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}