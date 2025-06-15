import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'service_restaurant.dart';
import 'model_review.dart';

class ReviewScreen extends StatefulWidget {
  final String restaurantId;

  const ReviewScreen({super.key, required this.restaurantId});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final _formKey = GlobalKey<FormState>();
  final _reviewController = TextEditingController();
  double _rating = 3.0;

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final restaurantService = Provider.of<MockRestaurantService>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Add Review')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                'How was your experience?',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 16),
              Slider(
                value: _rating,
                min: 1,
                max: 5,
                divisions: 4,
                activeColor: Colors.orange[800],
                inactiveColor: Colors.orange[200],
                label: _rating.toStringAsFixed(1),
                onChanged: (value) {
                  setState(() {
                    _rating = value;
                  });
                },
              ),
              Text(
                '${_rating.toStringAsFixed(1)} Stars',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.orange[800],
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _reviewController,
                decoration: const InputDecoration(
                  labelText: 'Your review',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your review';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      restaurantService.addReview(
                        Review(
                          id: DateTime.now().toString(),
                          userId: 'current_user_id',
                          userName: 'Current User',
                          restaurantId: widget.restaurantId,
                          text: _reviewController.text,
                          rating: _rating,
                          date: DateTime.now(),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Submit Review'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

