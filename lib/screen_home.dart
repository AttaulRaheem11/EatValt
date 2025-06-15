import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'service_restaurant.dart';
import 'widget_restaurant_card.dart';
import 'screen_search.dart';
import 'screen_restaurant_detail.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final restaurantService = Provider.of<MockRestaurantService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurants'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SearchScreen()),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: restaurantService.restaurants.length,
        itemBuilder: (context, index) {
          final restaurant = restaurantService.restaurants[index];
          return RestaurantCard(
            restaurant: restaurant,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RestaurantDetailScreen(restaurantId: restaurant.id),
              ),
            ),
          );
        },
      ),
    );
  }
}