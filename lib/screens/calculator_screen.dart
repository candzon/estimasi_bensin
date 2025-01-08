import 'package:fuelwise_news/widgets/custom_modal.dart';
import 'package:flutter/material.dart';
import '../models/predict.dart';
import '../services/api_service.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  CalculatorScreenState createState() => CalculatorScreenState();
}

class CalculatorScreenState extends State<CalculatorScreen> {
  String? selectedVehicle;
  String? selectedFuel;
  TextEditingController distanceController = TextEditingController();

  double? estimatedFuel;
  double? totalCost;

  final double fuelEfficiency = 30; // Konsumsi bahan bakar (km/L)
  var fuelPrice = 0; // Harga bahan bakar per liter (Rp)
  final ApiService apiService = ApiService();

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

        if (selectedVehicle != null && selectedFuel != null) {
          Predict predict = Predict(
            jarakTempuh: distance,
            bahanBakar: fuelTypes.indexOf(selectedFuel!).toDouble(),
            merkKendaraan: selectedVehicle!,
            estimasiBensin: estimatedFuel!,
            totalBiaya: totalCost!,
            photo: null,
          );

          apiService.createPredict(predict).then((_) {
            if (mounted) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const CustomModal(
                  message: 'Data berhasil dikirim ke server',
                  isSuccess: true,
                ),
              );
            }
          }).catchError((error) {
            if (mounted) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const CustomModal(
                  message: 'Gagal mengirim data ke server',
                  isSuccess: false,
                ),
              );
            }
          });
        }
      });
    }
  }

  Widget _buildResultSection() {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(top: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hasil Perhitungan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
              height: 16,
            ),
            const SizedBox(height: 8),
            _buildResultRow(
              'Estimasi Bensin:',
              estimatedFuel != null
                  ? '${estimatedFuel!.toStringAsFixed(2)} Liter'
                  : '-',
            ),
            _buildResultRow(
              'Total Biaya:',
              totalCost != null ? 'Rp${totalCost!.toStringAsFixed(0)}' : '-',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kalkulator Hemat Bensin',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.grey.shade100,
        elevation: 2,
        centerTitle: true,
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
              hint: Text(
                'Pilih Kendaraan',
                style: TextStyle(
                  color: Colors.grey.shade500,
                ),
              ),
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
              hint: Text(
                'Pilih Bahan Bakar',
                style: TextStyle(
                  color: Colors.grey.shade500,
                ),
              ),
              items: fuelTypes.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedFuel = newValue;
                  switch (newValue) {
                    case 'Pertalite':
                      fuelPrice = 10000;
                      break;
                    case 'Pertamax':
                      fuelPrice = 12100;
                      break;
                    case 'Pertamax Turbo':
                      fuelPrice = 13550;
                      break;
                  }
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
                  backgroundColor: Colors.grey.shade200,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Hitung',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            _buildResultSection(),
          ],
        ),
      ),
    );
  }
}
