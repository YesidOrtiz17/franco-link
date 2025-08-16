import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  bool isLoading = true;
  bool hasError = false;
  bool isLoggedIn = false;

  UserProvider() {
    loadSavedSession();
  }

  Future<void> loadSavedSession() async {
    try {
      isLoading = true;
      notifyListeners();

      // Simula carga de sesión guardada
      await Future.delayed(const Duration(seconds: 2));

      // Aquí deberías verificar sesión real
      isLoggedIn = false; // Cambiar a true si hay sesión guardada

    } catch (e) {
      hasError = true;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    isLoading = true;
    notifyListeners();
    try {
      // Simula login
      await Future.delayed(const Duration(seconds: 2));
      isLoggedIn = true;
    } catch (_) {
      hasError = true;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void logout() {
    isLoggedIn = false;
    notifyListeners();
  }
}
