import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'service_notification.dart';
import 'model_notification.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationService = Provider.of<NotificationService>(context);
    final notifications = notificationService.notifications;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          if (notificationService.unreadCount > 0)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Center(
                child: Text(
                  '${notificationService.unreadCount} new',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
      body: notifications.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.notifications_none,
                size: 64, color: Colors.orange[300]),
            const SizedBox(height: 16),
            Text(
              'No notifications',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.orange[100],
                child: Icon(
                  Icons.notifications,
                  color: notification.isRead
                      ? Colors.orange[400]
                      : Colors.orange[800],
                ),
              ),
              title: Text(notification.title),
              subtitle: Text(notification.message),
              trailing: !notification.isRead
                  ? const Icon(Icons.brightness_1,
                  size: 12, color: Colors.green)
                  : null,
              onTap: () {
                notificationService.markAsRead(notification.id);
              },
            ),
          );
        },
      ),
    );
  }
}