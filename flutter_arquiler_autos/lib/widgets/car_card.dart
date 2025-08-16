import 'package:flutter/material.dart';
import '../models/car.dart';

class CarCard extends StatelessWidget {
  final Car car;
  final VoidCallback onTap;

  const CarCard({super.key, required this.car, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16/9,
              child: Image.network(car.imageUrl, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const ColoredBox(color: Colors.black12)),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${car.brand} ${car.model} • ${car.year}', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text('COP ${car.pricePerDay.toStringAsFixed(0)}/día', style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(car.isAvailable ? Icons.check_circle : Icons.cancel, size: 18, color: car.isAvailable ? Colors.green : Colors.red),
                      const SizedBox(width: 6),
                      Text(car.isAvailable ? 'Disponible' : 'No disponible'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
