import 'package:flutter/material.dart';
import 'calculator_screen.dart';
import '../widgets/motorcycle_card.dart';
import '../widgets/article_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FuelWise Rides'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calculate),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CalculatorScreen()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MotorcycleCarousel(),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Article',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const ArticleList(), // Ini aja yang di perlukan untuk Article List
            const SizedBox(height: 16),
            // const MotorcycleList(), // Ini ga perlu budi heni
          ],
        ),
      ),
    );
  }
}
