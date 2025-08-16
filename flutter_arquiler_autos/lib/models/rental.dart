class Rental {
  final String id;
  final String carId;
  final String userId;
  final DateTime startDate;
  final DateTime endDate;
  final double totalCost;
  final String status; // pending, confirmed, cancelled
  final String paymentMethod; // cash, card, transfer

  Rental({
    required this.id,
    required this.carId,
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.totalCost,
    required this.status,
    required this.paymentMethod,
  });

  factory Rental.fromJson(Map<String, dynamic> json) => Rental(
        id: json['id'],
        carId: json['carId'],
        userId: json['userId'],
        startDate: DateTime.parse(json['startDate']),
        endDate: DateTime.parse(json['endDate']),
        totalCost: (json['totalCost'] as num).toDouble(),
        status: json['status'],
        paymentMethod: json['paymentMethod'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'carId': carId,
        'userId': userId,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'totalCost': totalCost,
        'status': status,
        'paymentMethod': paymentMethod,
      };
}
