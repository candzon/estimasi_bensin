// lib/models/motorcycle.dart
class Motorcycle {
  final String make;
  final String model;
  final String year;
  final String type;
  final String displacement;
  final String engine;
  final String power;
  final String torque;

  Motorcycle({
    required this.make,
    required this.model,
    required this.year,
    required this.type,
    required this.displacement,
    required this.engine,
    required this.power,
    required this.torque,
  });

  factory Motorcycle.fromJson(Map<String, dynamic> json) {
    return Motorcycle(
      make: json['make'] ?? '',
      model: json['model'] ?? '',
      year: json['year']?.toString() ?? '',
      type: json['type'] ?? '',
      displacement: json['displacement'] ?? '',
      engine: json['engine'] ?? '',
      power: json['power'] ?? '',
      torque: json['torque'] ?? '',
    );
  }
}
