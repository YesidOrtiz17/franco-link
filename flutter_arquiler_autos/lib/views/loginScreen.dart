import 'package:flutter/material.dart';
import 'package:flutter_arquiler_autos/views/menuPrincipal.dart';
import '../services/api_service.dart';
import 'package:flutter_arquiler_autos/views/registerScreen.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final Color fondo = const Color(0xFFAFDDFF);
  final Color encabezado = const Color(0xFF60B5FF);
  final Color campos = const Color(0xFFFFECDB);
  final Color boton = const Color(0xFFFF9149);
  final Color texto = const Color(0xFF222222);

  // Controladores para obtener los valores de los TextField
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Por favor ingresa correo y contraseña"),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    try {
      final api = ApiService();
      await api.login(email, password);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Menuprincipal()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Usuario o contraseña incorrectos"),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondo,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            Icon(Icons.person_pin, size: 100, color: encabezado),
            const SizedBox(height: 16),
            Text(
              "Bienvenido",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: encabezado,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Inicia sesión para continuar",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: texto.withOpacity(0.7)),
            ),
            const SizedBox(height: 90),

            // Campo correo
            TextField(
              controller: emailController,
              style: TextStyle(color: texto),
              decoration: InputDecoration(
                labelText: "Correo Electrónico",
                labelStyle: TextStyle(color: texto),
                filled: true,
                fillColor: campos,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Campo contraseña
            TextField(
              controller: passwordController,
              obscureText: true,
              style: TextStyle(color: texto),
              decoration: InputDecoration(
                labelText: "Contraseña",
                labelStyle: TextStyle(color: texto),
                prefixIcon: Icon(Icons.password, color: encabezado),
                filled: true,
                fillColor: campos,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Botón login
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: boton,
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text(
                "Iniciar Sesión",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),

            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '¿Olvidaste tu contraseña?',
                  style: TextStyle(color: texto),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Recuperar',
                    style: TextStyle(
                      color: encabezado,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("¿No tienes una cuenta? "),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: Text(
                    "Registrarse",
                    style: TextStyle(
                      color: Colors.pink[200],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
