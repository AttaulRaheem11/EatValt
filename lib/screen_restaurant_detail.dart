import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model_restaurant.dart';
import 'service_restaurant.dart';
import 'screen_review.dart';
import 'widget_review.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final String restaurantId;

  const RestaurantDetailScreen({super.key, required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    final restaurantService = Provider.of<MockRestaurantService>(context);
    final restaurant = restaurantService.getRestaurantById(restaurantId);
    final isFavorite = restaurantService.favorites
        .any((fav) => fav.id == restaurant.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: () =>
                restaurantService.toggleFavorite(restaurant.id),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(restaurant.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        restaurant.name,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.orange[700]),
                          const SizedBox(width: 4),
                          Text(
                            '${restaurant.rating}',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.orange[800],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: Colors.red[600]),
                      const SizedBox(width: 4),
                      Text(
                        restaurant.address,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    restaurant.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  if (restaurant.tags.isNotEmpty) ...[
                    Wrap(
                      spacing: 8,
                      children: restaurant.tags.map((tag) => Chip(
                        label: Text(tag),
                        backgroundColor: Colors.orange[50],
                      )).toList(),
                    ),
                    const SizedBox(height: 16),
                  ],
                  if (restaurant.deals.isNotEmpty) ...[
                    const Text(
                      'Current Deals',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...restaurant.deals.map((deal) => Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: Icon(Icons.local_offer, color: Colors.orange[800]),
                        title: Text(
                          deal.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange[900],
                          ),
                        ),
                        subtitle: Text(deal.description),
                        trailing: Text(
                          'Expires: ${deal.expiryDate.toLocal().toString().split(' ')[0]}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    )),
                    const SizedBox(height: 16),
                  ],
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Reviews',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ReviewScreen(
                              restaurantId: restaurant.id,
                            ),
                          ),
                        ),
                        child: const Text('Add Review'),
                      ),
                    ],
                  ),
                  ...restaurant.reviews.take(3).map(
                        (review) => ReviewWidget(review: review),
                  ),
                  if (restaurant.reviews.length > 3)
                    Center(
                      child: TextButton(
                        onPressed: () {
                          // Show all reviews
                        },
                        child: const Text('View all reviews'),
                      ),
                    ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Make reservation
                      },
                      child: const Text('Order'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
