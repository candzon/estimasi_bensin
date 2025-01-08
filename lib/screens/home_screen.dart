import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'calculator_screen.dart';
import '../widgets/motorcycle_carousel.dart';
import '../widgets/article_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();

  Future<void> _refreshData() async {
    await apiService.fetchPredicts();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        elevation: 2,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://almiftahuljannah.or.id/wp-content/uploads/2020/05/logo-berita-png-1.png', // Tambahkan logo aplikasi
              height: 30,
            ),
            const SizedBox(width: 8),
            const Text(
              'FuelWise News',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calculate, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CalculatorScreen(),
                ),
              );
            },
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.black), // Warna ikon
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MotorcycleCarousel(),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Articles',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const ArticleList(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}