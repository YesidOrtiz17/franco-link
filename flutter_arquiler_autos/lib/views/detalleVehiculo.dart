import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/car.dart';
import '../providers/rental_provider.dart';
import 'rental_form.dart';

class DetalleVehiculo extends StatelessWidget {
  final Car car;
  const DetalleVehiculo({Key? key, required this.car}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorPrincipal = Colors.pink[200] ?? Colors.pink;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrincipal,
        title: const Text('Detalle del Vehículo'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          color: colorPrincipal.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Imagen del vehículo
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      car.imageUrl,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Marca, modelo y año
                Text(
                  '${car.brand} ${car.model} (${car.year})',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 8),
                // Precio por día
                Row(
                  children: [
                    Icon(Icons.attach_money, color: Colors.green[700]),
                    const SizedBox(width: 4),
                    Text(
                      'Precio por día: \$${car.pricePerDay.toStringAsFixed(2)}',
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Descripción
                Text('Descripción: ${car.description}'),
                const SizedBox(height: 8),
                // Disponibilidad
                Text(
                  'Disponibilidad: ${car.isAvailable ? 'Disponible' : 'No disponible'}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: car.isAvailable ? Colors.green : Colors.red,
                  ),
                ),
                const Divider(height: 32, thickness: 1),
                // Detalles adicionales (solo si existen)
                if (car.color != null) Text('Color: ${car.color}'),
                if (car.transmission != null)
                  Text('Transmisión: ${car.transmission}'),
                if (car.fuelType != null) Text('Combustible: ${car.fuelType}'),
                if (car.seats != null)
                  Text('Capacidad de pasajeros: ${car.seats}'),
                const SizedBox(height: 16),
                // Botón de alquiler que abre el formulario
                if (car.isAvailable)
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorPrincipal,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    icon: const Icon(Icons.directions_car),
                    label: const Text(
                      'Alquilar Vehículo',
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () => _showRentalForm(context),
                  ),
                if (!car.isAvailable)
                  const Text(
                    'Este vehículo no está disponible para alquilar.',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Función para mostrar el formulario de alquiler
  void _showRentalForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 24,
        ),
        child: RentalForm(
          pricePerDay: car.pricePerDay,
          onSubmit:
              ({
                required name,
                required email,
                required phone,
                required license,
                required startDate,
                required endDate,
                required totalPrice,
              }) async {
                final rentalProvider = Provider.of<RentalProvider>(
                  ctx,
                  listen: false,
                );
                await rentalProvider.createRental(
                  carId: car.id,
                  userId: email,
                  startDate: startDate,
                  endDate: endDate,
                  pricePerDay: car.pricePerDay,
                  paymentMethod: 'Formulario',
                );
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('¡Alquiler realizado para $name!')),
                );
              },
        ),
      ),
    );
  }

  // (El método _rentVehicle y _showPaymentOptions ya no se usan)
}
