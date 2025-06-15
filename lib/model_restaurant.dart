import 'model_deal.dart';
import 'model_review.dart';

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double rating;
  final String address;
  final List<String> tags;
  final List<Deal> deals;
  final List<Review> reviews;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    this.rating = 0.0,
    required this.address,
    this.tags = const [],
    this.deals = const [],
    this.reviews = const [],
  });
}

