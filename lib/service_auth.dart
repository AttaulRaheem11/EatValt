import 'package:flutter/material.dart';
import 'model_user.dart';

class FakeAuthService with ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;
  bool _isLoggedIn = false;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _currentUser = User(
      id: '1',
      name: 'Test User',
      email: email,
      phone: '+1234567890',
    );
    _isLoggedIn = true;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    _currentUser = null;
    _isLoggedIn = false;
    notifyListeners();
  }

  Future<void> verifyOtp(String otp) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    _isLoading = false;
    notifyListeners();
  }
}