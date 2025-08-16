import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';
import '../models/car.dart';
import '../models/rental.dart';
import '../models/user.dart';

class ApiService {
  ApiService({this.mockMode = true, this.authToken});
  final bool mockMode;
  final String? authToken;

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      };

  // ---------------- MOCK DATA ----------------
  static final List<Car> _mockCars = [
    Car(
      id: '1',
      brand: 'Toyota',
      model: 'Corolla',
      year: 2022,
      pricePerDay: 120000,
      imageUrl: 'https://images.unsplash.com/photo-1619767886558-efdc259cde1b',
      isAvailable: true,
      description: 'Económico, confiable y eficiente.',
    ),
    Car(
      id: '2',
      brand: 'Mazda',
      model: '3',
      year: 2023,
      pricePerDay: 150000,
      imageUrl: 'https://images.unsplash.com/photo-1549921296-3ecf4a2b1d9f',
      isAvailable: true,
      description: 'Compacto con buen performance.',
    ),
    Car(
      id: '3',
      brand: 'Chevrolet',
      model: 'Tracker',
      year: 2021,
      pricePerDay: 200000,
      imageUrl: 'https://images.unsplash.com/photo-1593941707874-ef25b8b3b6b9',
      isAvailable: false,
      description: 'SUV cómodo para la familia.',
    ),
  ];

  // ---------------- AUTH ----------------
  Future<User> login(String email, String password) async {
    if (mockMode) {
      await Future.delayed(const Duration(milliseconds: 600));
      return User(id: 'u1', name: 'Usuario Demo', email: email, token: 'demo-token');
    }
    final uri = Uri.parse('$API_BASE_URL/auth/login');
    final res = await http.post(uri, headers: _headers, body: jsonEncode({'email': email, 'password': password}));
    if (res.statusCode == 200) {
      return User.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Login failed: ${res.statusCode}');
    }
  }

  Future<User> register(String name, String email, String password) async {
    if (mockMode) {
      await Future.delayed(const Duration(milliseconds: 800));
      return User(id: 'u2', name: name, email: email, token: 'demo-token-2');
    }
    final uri = Uri.parse('$API_BASE_URL/auth/register');
    final res = await http.post(uri, headers: _headers, body: jsonEncode({'name': name, 'email': email, 'password': password}));
    if (res.statusCode == 201) {
      return User.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Register failed: ${res.statusCode}');
    }
  }

  // ---------------- CARS ----------------
  Future<List<Car>> fetchCars() async {
    if (mockMode) {
      await Future.delayed(const Duration(milliseconds: 500));
      return _mockCars;
    }
    final uri = Uri.parse('$API_BASE_URL/cars');
    final res = await http.get(uri, headers: _headers);
    if (res.statusCode == 200) {
      final list = jsonDecode(res.body) as List;
      return list.map((e) => Car.fromJson(e)).toList();
    } else {
      throw Exception('Fetch cars failed: ${res.statusCode}');
    }
  }

  // ---------------- RENTALS ----------------
  Future<Rental> createRental(Rental rental) async {
    if (mockMode) {
      await Future.delayed(const Duration(milliseconds: 700));
      return rental;
    }
    final uri = Uri.parse('$API_BASE_URL/rentals');
    final res = await http.post(uri, headers: _headers, body: jsonEncode(rental.toJson()));
    if (res.statusCode == 201) {
      return Rental.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Create rental failed: ${res.statusCode}');
    }
  }
}
