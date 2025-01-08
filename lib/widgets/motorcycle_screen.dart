import 'package:flutter/material.dart';

class MotorcycleCarousel extends StatelessWidget {
  const MotorcycleCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Center(
                  child: Image.asset(
                    'images/beat.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      '48 km/L',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
