import 'package:flutter/material.dart';
import 'model_review.dart';

class ReviewWidget extends StatelessWidget {
  final Review review;

  const ReviewWidget({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  review.userName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange[700], size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '${review.rating}',
                      style: TextStyle(color: Colors.orange[800]),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              review.text,
              style: const TextStyle(color: Colors.black87),
            ),
            const SizedBox(height: 8),
            Text(
              '${review.date.toLocal()}'.split(' ')[0],
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}