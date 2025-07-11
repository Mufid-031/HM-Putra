import 'package:flutter/material.dart';

class LoginViewModel with ChangeNotifier {
  String email = '';
  String password = '';

  bool isLoading = false;
  String? errorMessage;

  void setEmail(String value) {
    email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    password = value;
    notifyListeners();
  }

  Future<bool> login() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    if (email == 'admin@gmail.com' && password == 'admin123') {
      isLoading = false;
      notifyListeners();
      return true;
    } else {
      errorMessage = 'Email atau password salah';
      isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
