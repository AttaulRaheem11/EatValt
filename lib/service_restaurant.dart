import 'package:flutter/material.dart';
import 'model_restaurant.dart';
import 'model_review.dart';
import 'model_deal.dart';

class MockRestaurantService with ChangeNotifier {
  final List<Restaurant> _restaurants = [];
  final List<Restaurant> _favorites = [];
  final List<Review> _reviews = [];

  List<Restaurant> get restaurants => _restaurants;
  List<Restaurant> get favorites => _favorites;
  List<Restaurant> get deals => _restaurants.where((r) => r.deals.isNotEmpty).toList();
  List<Review> get reviews => _reviews;

  MockRestaurantService() {
    _initializeMockData();
  }

  void _initializeMockData() {
    _restaurants.addAll([
      Restaurant(
        id: '1',
        name: 'Burger Palace',
        description: 'Best burgers in town',
        imageUrl: 'https://example.com/burger.jpg',
        rating: 4.5,
        address: '123 Main St',
        tags: ['Burgers', 'Fast Food'],
        deals: [
          Deal(
            id: '1',
            title: '20% Off',
            description: 'On all burgers',
            expiryDate: DateTime.now().add(const Duration(days: 7)),
          ),
        ],
      ),
      Restaurant(
        id: '2',
        name: 'Pizza Heaven',
        description: 'Authentic Italian pizza',
        imageUrl: 'https://example.com/pizza.jpg',
        rating: 4.7,
        address: '456 Oak Ave',
        tags: ['Pizza', 'Italian'],
      ),
    ]);

    _reviews.addAll([
      Review(
        id: '1',
        userId: '1',
        userName: 'Test User',
        restaurantId: '1',
        text: 'Great burgers!',
        rating: 5.0,
        date: DateTime.now(),
      ),
    ]);
  }

  Restaurant getRestaurantById(String id) {
    return _restaurants.firstWhere((r) => r.id == id);
  }

  void addReview(Review review) {
    _reviews.add(review);
    notifyListeners();
  }

  void toggleFavorite(String restaurantId) {
    final index = _favorites.indexWhere((r) => r.id == restaurantId);
    if (index >= 0) {
      _favorites.removeAt(index);
    } else {
      final restaurant = _restaurants.firstWhere((r) => r.id == restaurantId);
      _favorites.add(restaurant);
    }
    notifyListeners();
  }

  void addDeal(String restaurantId, Deal deal) {
    final restaurant = _restaurants.firstWhere((r) => r.id == restaurantId);
    restaurant.deals.add(deal);
    notifyListeners();
  }
}

