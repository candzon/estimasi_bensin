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

  @override
  void initState() {
    super.initState();
    _predictsFuture = _apiService.fetchPredicts();
    _pageController = PageController(initialPage: _currentPage);

    // Timer untuk auto-scroll
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        setState(() {
          _currentPage = (_currentPage + 1) % 5; // Loop ke index pertama
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
          height: 250,
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

              return Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
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
                                  color: Colors.grey.shade500,
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
                  // Panah Navigasi
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        if (_currentPage > 0) {
                          setState(() {
                            _currentPage--;
                            _pageController.animateToPage(
                              _currentPage,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          });
                        }
                      },
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        setState(() {
                          _currentPage++;
                          _pageController.animateToPage(
                            _currentPage,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        });
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        FutureBuilder<List<Predict>>(
          future: _predictsFuture,
          builder: (context, snapshot) {
            final predicts = snapshot.data ?? [];
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(predicts.length, (index) {
                return Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color:
                        _currentPage == index ? Colors.blue : Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                );
              }),
            );
          },
        ),
      ],
    );
  }
}
