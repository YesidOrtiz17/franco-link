import 'package:flutter/material.dart';
import '../models/car.dart';
import '../services/api_service.dart';

class CarProvider extends ChangeNotifier {
  bool isLoading = true;
  bool hasError = false;
  List<Car> cars = [];
  final ApiService _api = ApiService(mockMode: true);

  CarProvider() {
    loadCars();
  }

  Future<void> loadCars() async {
    try {
      isLoading = true;
      notifyListeners();
      cars = await _api.fetchCars();
    } catch (_) {
      hasError = true;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
