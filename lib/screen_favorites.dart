import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'service_restaurant.dart';
import 'widget_restaurant_card.dart';
import 'screen_restaurant_detail.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final restaurantService = Provider.of<MockRestaurantService>(context);
    final favorites = restaurantService.favorites;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorites'),
      ),
      body: favorites.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border,
                size: 64, color: Colors.orange[300]),
            const SizedBox(height: 16),
            Text(
              'No favorites yet',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap the heart icon on restaurants to add them here',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final restaurant = favorites[index];
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