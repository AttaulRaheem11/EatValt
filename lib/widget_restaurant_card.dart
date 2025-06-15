import 'package:flutter/material.dart';
import 'model_restaurant.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final VoidCallback? onTap;

  const RestaurantCard({
    super.key,
    required this.restaurant,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  restaurant.imageUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 100,
                    height: 100,
                    color: Colors.orange[100],
                    child: Icon(Icons.restaurant, color: Colors.orange[800]),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange[700], size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '${restaurant.rating}',
                          style: TextStyle(color: Colors.orange[800]),
                        ),
                        const SizedBox(width: 16),
                        Icon(Icons.location_on, size: 16, color: Colors.red[600]),
                        const SizedBox(width: 4),
                        Text(
                          restaurant.address,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      restaurant.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    if (restaurant.deals.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Chip(
                        label: Text(
                          restaurant.deals.first.title,
                          style: TextStyle(
                            color: Colors.orange[900],
                            fontSize: 12,
                          ),
                        ),
                        backgroundColor: Colors.orange[50],
                        side: BorderSide.none,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
