import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'service_auth.dart';
import 'screen_main_navigation.dart';
import 'screen_onboarding.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<FakeAuthService>(context, listen: false);

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => authService.isLoggedIn
              ? const MainNavigationScreen()
              : const OnboardingScreen(),
        ),
      );
    });

    return Scaffold(
      backgroundColor: Colors.orange[800],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/image/eatvalt_logo.png',
              height: 280,      // Adjust as needed
              width: 280,       // Adjust as needed
              fit: BoxFit.contain, // Ensures the logo scales properly
            ),
            const SizedBox(height: 20),
            Text(
              'EatValt',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}