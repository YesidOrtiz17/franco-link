import 'package:flutter/foundation.dart';
import '../models/rental.dart';
import '../services/api_service.dart';

class RentalProvider extends ChangeNotifier {
  final ApiService _api = ApiService(mockMode: true);
  final List<Rental> _rentals = [];
  bool _loading = false;

  List<Rental> get rentals => List.unmodifiable(_rentals);
  bool get isLoading => _loading;

  Future<Rental> createRental({
    required String carId,
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
    required double pricePerDay,
    required String paymentMethod,
  }) async {
    _loading = true; notifyListeners();
    try {
      final days = endDate.difference(startDate).inDays.clamp(1, 365);
      final total = days * pricePerDay;
      final rental = Rental(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        carId: carId,
        userId: userId,
        startDate: startDate,
        endDate: endDate,
        totalCost: total.toDouble(),
        status: 'confirmed',
        paymentMethod: paymentMethod,
      );
      final created = await _api.createRental(rental);
      _rentals.add(created);
      notifyListeners();
      return created;
    } finally {
      _loading = false; notifyListeners();
    }
  }
}
