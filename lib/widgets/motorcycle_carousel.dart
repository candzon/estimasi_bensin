import 'package:flutter/material.dart';
import 'dart:async';
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
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;
  final double _viewportFraction = 0.75;

  @override
  void initState() {
    super.initState();
    _predictsFuture = _apiService.fetchPredicts();
    _pageController = PageController(
      initialPage: _currentPage,
      viewportFraction: _viewportFraction,
    );

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        setState(() {
          _currentPage = (_currentPage + 1) % 5;
          _pageController.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 280,
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

              return PageView.builder(
                controller: _pageController,
                itemCount: predicts.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final predict = predicts[index];
                  return AnimatedBuilder(
                    animation: _pageController,
                    builder: (context, child) {
                      double value = 1.0;
                      if (_pageController.position.haveDimensions) {
                        value = (_pageController.page ?? 0) - index;
                        value = (1 - (value.abs() * 0.4)).clamp(0.0, 1.0);
                      }

                      return Transform.scale(
                        scale: value,
                        child: Opacity(
                          opacity: value,
                          child: child,
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 16.0,
                      ),
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                predict.merkKendaraan == "Beat"
                                    ? 'images/beat.png'
                                    : predict.merkKendaraan == "Scoopy"
                                        ? 'images/scoopy.jpeg'
                                        : predict.merkKendaraan ==
                                                "Suzuki nex II"
                                            ? 'images/suzuki-nex.jpeg'
                                            : predict.merkKendaraan == "Vario"
                                                ? 'images/vario.jpeg'
                                                : 'images/default.png',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
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
                                color: Colors.black.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    predict.merkKendaraan,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${predict.jarakTempuh} km',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    'Rp ${predict.totalBiaya.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
