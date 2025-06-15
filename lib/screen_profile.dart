import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'service_auth.dart';
import 'screen_favorites.dart';
import 'screen_notifications.dart';
import 'screen_edit_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<FakeAuthService>(context);
    final user = authService.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.orange[100],
              backgroundImage: user?.profileImage != null
                  ? NetworkImage(user!.profileImage!)
                  : null,
              child: user?.profileImage == null
                  ? Icon(Icons.person, size: 50, color: Colors.orange[800])
                  : null,
            ),
            const SizedBox(height: 16),
            Text(
              user?.name ?? 'No Name',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).primaryColor,
              ),
            ),
            Text(user?.email ?? 'No Email'),
            const SizedBox(height: 24),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.edit, color: Colors.orange[800]),
                    title: const Text('Edit Profile'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const EditProfileScreen(),
                      ),
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.favorite, color: Colors.orange[800]),
                    title: const Text('My Favorites'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const FavoritesScreen()),
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.notifications, color: Colors.orange[800]),
                    title: const Text('Notifications'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const NotificationsScreen(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[600],
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  await authService.logout();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/',
                        (route) => false,
                  );
                },
                child: const Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}