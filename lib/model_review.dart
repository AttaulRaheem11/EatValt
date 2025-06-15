class Review {
  final String id;
  final String userId;
  final String userName;
  final String restaurantId;
  final String text;
  final double rating;
  final DateTime date;

  Review({
    required this.id,
    required this.userId,
    required this.userName,
    required this.restaurantId,
    required this.text,
    required this.rating,
    required this.date,
  });
}