import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String? selectedVehicle;
  String? selectedFuel;
  TextEditingController distanceController = TextEditingController();

  double? estimatedFuel;
  double? totalCost;

  final double fuelEfficiency = 30; // Konsumsi bahan bakar (km/L)
  final double fuelPrice = 10000; // Harga bahan bakar per liter (Rp)

  final List<String> vehicleTypes = [
    'Suzuki nex II',
    'Beat',
    'Scoopy',
    'Vario'
  ];
  final List<String> fuelTypes = ['Pertalite', 'Pertamax', 'Pertamax Turbo'];

  @override
  void initState() {
    super.initState();
    distanceController.addListener(_onDistanceChanged);
  }

  @override
  void dispose() {
    distanceController.removeListener(_onDistanceChanged);
    distanceController.dispose();
    super.dispose();
  }

  void _onDistanceChanged() {
    if (distanceController.text.isEmpty) {
      setState(() {
        estimatedFuel = null;
        totalCost = null;
      });
    }
  }

  void calculateFuelAndCost() {
    if (distanceController.text.isNotEmpty) {
      final double distance = double.tryParse(distanceController.text) ?? 0;

      setState(() {
        estimatedFuel = distance / fuelEfficiency;
        totalCost = (estimatedFuel ?? 0) * fuelPrice;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator Hemat Bensin'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Kendaraan'),
            DropdownButton<String>(
              isExpanded: true,
              value: selectedVehicle,
              hint: const Text('Pilih Kendaraan'),
              items: vehicleTypes.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedVehicle = newValue;
                });
              },
            ),
            const SizedBox(height: 16),
            const Text('Bahan Bakar'),
            DropdownButton<String>(
              isExpanded: true,
              value: selectedFuel,
              hint: const Text('Pilih Bahan Bakar'),
              items: fuelTypes.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedFuel = newValue;
                });
              },
            ),
            const SizedBox(height: 16),
            const Text('Jarak tempuh (dalam km)'),
            TextField(
              controller: distanceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Masukkan jarak dalam km',
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: calculateFuelAndCost,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Hitung'),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Hasil'),
            const SizedBox(height: 8),
            Text(
              'Estimasi Bensin: ${estimatedFuel != null ? '${estimatedFuel!.toStringAsFixed(2)} Liter' : '-'}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Total Biaya: ${totalCost != null ? 'Rp${totalCost!.toStringAsFixed(0)}' : '-'}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
