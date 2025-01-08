import 'package:flutter/material.dart';
import '../models/predict.dart';
import '../services/api_service.dart';

class MotorcycleCarousel extends StatefulWidget {
  const MotorcycleCarousel({super.key});

  @override
  State<MotorcycleCarousel> createState() => _MotorcycleCarouselState();
}

class _MotorcycleCarouselState extends State<MotorcycleCarousel> {
  final ApiService _apiService = ApiService();
  late Future<List<Predict>> _predictsFuture;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _predictsFuture = _apiService.fetchPredicts();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 220,
          child: FutureBuilder<List<Predict>>(
            future: _predictsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              final predicts = snapshot.data ?? [];

              return Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      itemCount: predicts.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        final predict = predicts[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          color: Colors.white,
                          child: Stack(
                            children: [
                              Center(
                                child: SizedBox(
                                  width: 200,
                                  height: 150,
                                  child: Image.asset(
                                    predict.merkKendaraan == "Beat" ? 'images/beat.png' :
                                    predict.merkKendaraan == "Scoopy" ? 'images/scoopy.jpeg' :
                                    predict.merkKendaraan == "Suzuki nex II" ? 'images/suzuki-nex.jpeg' :
                                    predict.merkKendaraan == "Vario" ? 'images/vario.jpeg' :
                                    'images/default.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 16,
                                left: 16,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        predict.merkKendaraan,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${predict.jarakTempuh} km',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Rp ${predict.totalBiaya.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(predicts.length, (index) {
                      return Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          color: _currentPage == index ? Colors.blue : Colors.grey[300],
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}