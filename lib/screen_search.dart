import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'service_restaurant.dart';
import 'widget_restaurant_card.dart';
import 'screen_restaurant_detail.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  String _searchTerm = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final restaurantService = Provider.of<MockRestaurantService>(context);
    final filteredRestaurants = restaurantService.restaurants
        .where((restaurant) => restaurant.name.toLowerCase()
        .contains(_searchTerm.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search restaurants...',
            border: InputBorder.none,
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _searchTerm.isNotEmpty
                ? IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                setState(() {
                  _searchTerm = '';
                });
              },
            )
                : null,
          ),
          onChanged: (value) {
            setState(() {
              _searchTerm = value;
            });
          },
        ),
      ),
      body: _searchTerm.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 64, color: Colors.orange[300]),
            const SizedBox(height: 16),
            Text(
              'Search for restaurants',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      )
          : filteredRestaurants.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.orange[300]),
            const SizedBox(height: 16),
            Text(
              'No results found',
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
        itemCount: filteredRestaurants.length,
        itemBuilder: (context, index) {
          final restaurant = filteredRestaurants[index];
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