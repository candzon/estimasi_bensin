import 'package:flutter/material.dart';
import '../models/motorcycle.dart';
import '../services/api_service.dart';

class MotorcycleList extends StatefulWidget {
  const MotorcycleList({super.key});

  @override
  State<MotorcycleList> createState() => _MotorcycleListState();
}

class _MotorcycleListState extends State<MotorcycleList> {
  final ApiService _apiService = ApiService();
  late Future<List<Motorcycle>> _motorcyclesFuture;

  @override
  void initState() {
    super.initState();
    _motorcyclesFuture = _apiService.getMotorcycles();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Motorcycle>>(
      future: _motorcyclesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final motorcycles = snapshot.data ?? [];

        if (motorcycles.isEmpty) {
          return const Center(child: Text('Tidak ada data motor'));
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'images/beat.png',
                      width: 80,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Honda PCX 160 vs Yamaha Nmax Turbo: Duel Sengit Skutik Bongsor, Mana Juaranya?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '12 November 2023',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
