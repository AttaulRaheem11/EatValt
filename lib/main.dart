import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'service_auth.dart';
import 'service_restaurant.dart';
import 'service_notification.dart';
import 'screen_splash.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FakeAuthService()),
        ChangeNotifierProvider(create: (_) => MockRestaurantService()),
        ChangeNotifierProvider(create: (_) => NotificationService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EatValt',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        primaryColor: Colors.orange[800],
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.orange,
          accentColor: Colors.red[600],
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.orange[800],
          foregroundColor: Colors.white,
          elevation: 4,
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange[800],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.orange[800],
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange[800]!),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: Colors.orange[50],
          labelStyle: const TextStyle(color: Colors.black87),
          selectedColor: Colors.orange[800],
          secondaryLabelStyle: const TextStyle(color: Colors.white),
        ),
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}