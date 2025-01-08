import 'package:fuelwise_news/constants/app_pallete.dart';
import 'package:fuelwise_news/constants/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    // print("Error loading .env file: $e");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FuelWise Rides',
      theme: AppThemes.createThemeData(AppPallete.newsTheme),
      home: const HomeScreen(),
    );
  }
}
