import 'package:flutter/material.dart';
import '../models/motorcycle.dart';
import '../services/api_service.dart';

class MotorcycleCarousel extends StatefulWidget {
  const MotorcycleCarousel({super.key});

  @override
  State<MotorcycleCarousel> createState() => _MotorcycleCarouselState();
}

class _MotorcycleCarouselState extends State<MotorcycleCarousel> {
  final ApiService _apiService = ApiService();
  late Future<List<Motorcycle>> _motorcyclesFuture;

  @override
  void initState() {
    super.initState();
    _motorcyclesFuture =
        _apiService.getMotorcycles(make: 'Kawasaki', model: 'Ninja');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 220,
          child: FutureBuilder<List<Motorcycle>>(
            future: _motorcyclesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              final motorcycles = snapshot.data ?? [];

              return PageView.builder(
                itemCount: motorcycles.length,
                itemBuilder: (context, index) {
                  final motorcycle = motorcycles[index];
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
                              'images/beat.png',
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
                                  motorcycle.make,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '48 km/L',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Rp 27.040',
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
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
