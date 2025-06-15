import 'package:flutter/material.dart';
import 'model_notification.dart';

class NotificationService with ChangeNotifier {
  final List<AppNotification> _notifications = [];

  List<AppNotification> get notifications => _notifications;
  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  NotificationService() {
    _initializeMockData();
  }

  void _initializeMockData() {
    _notifications.addAll([
      AppNotification(
        id: '1',
        title: 'Welcome!',
        message: 'Thanks for joining our app',
        date: DateTime.now().subtract(const Duration(days: 1)),
      ),
      AppNotification(
        id: '2',
        title: 'Special Offer',
        message: '20% off your first order',
        date: DateTime.now(),
      ),
    ]);
  }

  void markAsRead(String id) {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index >= 0) {
      _notifications[index].isRead = true;
      notifyListeners();
    }
  }

  void addNotification(AppNotification notification) {
    _notifications.insert(0, notification);
    notifyListeners();
  }
}