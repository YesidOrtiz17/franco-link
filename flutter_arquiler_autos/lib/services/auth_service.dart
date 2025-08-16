import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = "http://10.0.2.2:3000"; // Android emulator
  // Si usas web o Windows, cambia por http://localhost:3000

  static Future<bool> registerUser(String nombre, String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/users/agrege"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "nombre": nombre,
        "email": email,
        "password": password,
      }),
    );

    return response.statusCode == 201;
  }

  static Future<bool> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/users/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("Usuario logeado: ${data['user']['nombre']}");
      return true;
    } else {
      return false;
    }
  }
}
