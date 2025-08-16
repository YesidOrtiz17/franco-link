import 'package:flutter/material.dart';
import 'package:flutter_arquiler_autos/views/detalleVehiculo.dart';
import '../models/car.dart';
import 'package:flutter_arquiler_autos/views/login/login_screen.dart';
import 'package:flutter_arquiler_autos/views/menuDrawerPerfil.dart';

import 'package:provider/provider.dart';
import '../providers/rental_provider.dart';

class Menuprincipal extends StatefulWidget {
  @override
  _MenuprincipalState createState() => _MenuprincipalState();
}

class _MenuprincipalState extends State<Menuprincipal> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final Color fondo = Color(0xFFFFFFFF);
    final Color primario = Color(0xFF60B5FF);
    final Color secundario = Color(0xFFAFDDFF);
    final Color texto = Color(0xFF222222);
    Widget body;
    if (_currentIndex == 0) {
      body = Column(
        children: [
          TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: primario),
              hintText: "Buscar vehículo",
              hintStyle: TextStyle(color: texto.withOpacity(0.5)),
              filled: true,
              fillColor: secundario,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: listaDeAutos.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Image.network(
                    listaDeAutos[index]['imageUrl'],
                    width: 50,
                    height: 50,
                  ),
                  title: Text(
                    '${listaDeAutos[index]['marca']} Modelo ${listaDeAutos[index]['modelo']}',
                  ),
                  subtitle: Text(
                    'Año ${listaDeAutos[index]['año']} - ${listaDeAutos[index]['precio']}',
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.blue[300],
                  ),
                  onTap: () {
                    final map = listaDeAutos[index];
                    final car = Car(
                      id: map['marca'] + map['modelo'],
                      brand: map['marca'],
                      model: map['modelo'],
                      year: int.tryParse(map['año']) ?? 2020,
                      pricePerDay:
                          double.tryParse(
                            map['precio'].replaceAll(RegExp(r'[^0-9.]'), ''),
                          ) ??
                          0.0,
                      description: '',
                      imageUrl: map['imageUrl'],
                      isAvailable: map['disponibilidad'] == 1,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalleVehiculo(car: car),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      );
    } else if (_currentIndex == 1) {
      body = Consumer<RentalProvider>(
        builder: (context, rentalProvider, _) {
          final rentals = rentalProvider.rentals;
          if (rentals.isEmpty) {
            return const Center(
              child: Text('No has realizado alquileres aún.'),
            );
          }
          return ListView.builder(
            itemCount: rentals.length,
            itemBuilder: (context, index) {
              final rental = rentals[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: ListTile(
                  leading: const Icon(Icons.directions_car, color: Colors.blue),
                  title: Text('Auto: ${rental.carId}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Usuario: ${rental.userId}'),
                      Text(
                        'Desde: ${rental.startDate.toLocal().toString().split(' ')[0]}',
                      ),
                      Text(
                        'Hasta: ${rental.endDate.toLocal().toString().split(' ')[0]}',
                      ),
                      Text('Método de pago: ${rental.paymentMethod}'),
                      Text('Estado: ${rental.status}'),
                    ],
                  ),
                  trailing: Text(
                    'Total:\n\$${rental.totalCost.toStringAsFixed(2)}',
                    textAlign: TextAlign.right,
                  ),
                ),
              );
            },
          );
        },
      );
    } else {
      body = Container();
    }

    return Scaffold(
      backgroundColor: fondo,
      drawer: Menudrawerperfil(),
      appBar: AppBar(
        title: Text("Alquiler de Vehiculos"),
        backgroundColor: primario,
        foregroundColor: Colors.white,
      ),
      body: Padding(padding: EdgeInsets.all(16), child: body),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: primario,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: "Alquiler",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Usuario"),
        ],
      ),
    );
  }
}

List<Map<String, dynamic>> listaDeAutos = [
  {
    'marca': 'Toyota',
    'modelo': 'Corolla',
    'año': "2022",
    'disponibilidad': 1,
    'precio': '\$20,000',
    'imageUrl': '../assets/image.png',
  },
  {
    'marca': 'Nissan',
    'modelo': 'Sentra',
    'año': "2021",
    'disponibilidad': 1,
    'precio': '\$89.99/dia',
    'imageUrl': '../assets/descarga1.jpeg',
  },
  {
    'marca': 'Ford',
    'modelo': 'Mustang',
    'año': "2023",
    'disponibilidad': 0,
    'precio': '\$199.99/dia',
    'imageUrl': '../assets/descarga2.jpeg',
  },
  {
    'marca': 'Chevrolet',
    'modelo': 'Camaro',
    'año': "2020",
    'disponibilidad': 1,
    'precio': '\$150.00/dia',
    'imageUrl': '../assets/descarga3.jpeg',
  },
];
