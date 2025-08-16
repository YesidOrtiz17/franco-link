import 'package:flutter/material.dart';
import 'package:flutter_arquiler_autos/views/home/home_screen.dart';
import 'package:flutter_arquiler_autos/views/login/login_screen.dart';
import 'package:provider/provider.dart';

import 'utils/constants.dart';
import 'providers/car_provider.dart';
import 'providers/user_provider.dart';
import 'providers/rental_provider.dart';

// Vistas
import 'views/loginScreen.dart';
import 'views/menuPrincipal.dart';
import 'views/home/home_screen.dart'; 

void main() {
  runApp(CarRentalApp());
}

class CarRentalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => CarProvider()),
        ChangeNotifierProvider(create: (_) => RentalProvider()),
      ],
      child: MaterialApp(
        title: 'Car Rental',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          useMaterial3: true,
        ),
        initialRoute: '/', 
        routes: {
          '/': (_) => HomeScreen(),
          '/login': (_) => Loginscreen(),
          '/menu': (_) => Menuprincipal(),
          '/home': (context) => const HomeScreen(),
        },
      ),
    );
  }
}
