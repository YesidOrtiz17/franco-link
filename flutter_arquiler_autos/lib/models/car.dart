class Car {
  final String id;
  final String brand;
  final String model;
  final int year;
  final double pricePerDay;
  final String imageUrl;
  final bool isAvailable;
  final String description;

  // Nuevos campos opcionales
  final String? color;
  final String? transmission;
  final String? fuelType;
  final int? seats;

  Car({
    required this.id,
    required this.brand,
    required this.model,
    required this.year,
    required this.pricePerDay,
    required this.imageUrl,
    required this.isAvailable,
    required this.description,
    this.color,
    this.transmission,
    this.fuelType,
    this.seats,
  });

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        id: json['id'],
        brand: json['brand'],
        model: json['model'],
        year: json['year'],
        pricePerDay: (json['pricePerDay'] as num).toDouble(),
        imageUrl: json['imageUrl'],
        isAvailable: json['isAvailable'],
        description: json['description'] ?? '',
        color: json['color'],
        transmission: json['transmission'],
        fuelType: json['fuelType'],
        seats: json['seats'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'brand': brand,
        'model': model,
        'year': year,
        'pricePerDay': pricePerDay,
        'imageUrl': imageUrl,
        'isAvailable': isAvailable,
        'description': description,
        'color': color,
        'transmission': transmission,
        'fuelType': fuelType,
        'seats': seats,
      };
}
