import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/motorcycle.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/predict.dart';

class ApiService {
  static const String apiKey = 'Lnh4vtS3k9f6q1p/IH+dew==Oml0r22EKCj9xbwP';
  final String baseUrl = dotenv.env['BASE_URL']!;

  Future<List<Predict>> fetchPredicts() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/predicts'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Predict.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load predicts: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> createPredict(Predict predict) async {
    final response = await http.post(
      Uri.parse('$baseUrl/predicts/new'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(predict.toJson()),
    );
    if (response.statusCode == 201) {
      print('Predict created successfully');
    } else {
      throw Exception('Failed to create predict');
    }
  }

  Future<List<Article>> getArticles() async {
    // Static article data
    return [
      Article(
          id: 1,
          title:
              'Honda PCX 160 vs Yamaha Nmax Turbo: Duel Sengit Skutik Bongsor, Mana Juaranya?',
          imageUrl: 'images/beat.png',
          content: 'Lorem ipsum dolor sit amet...',
          date: '12 November 2023'),
      Article(
          id: 2,
          title:
              'Honda PCX 160 vs Yamaha Nmax Turbo: Duel Sengit Skutik Bongsor, Mana Juaranya?',
          imageUrl: 'images/beat.png',
          content: 'Lorem ipsum dolor sit amet...',
          date: '12 November 2023'),
      Article(
          id: 3,
          title:
              'Honda PCX 160 vs Yamaha Nmax Turbo: Duel Sengit Skutik Bongsor, Mana Juaranya?',
          imageUrl: 'images/beat.png',
          content: 'Lorem ipsum dolor sit amet...',
          date: '12 November 2023'),
    ];
  }

  Future<List<Motorcycle>> getMotorcycles({String? make, String? model}) async {
    try {
      final uri = Uri.parse('$baseUrl/motorcycles').replace(queryParameters: {
        'make': make ?? 'Kawasaki',
        'model': model ?? 'Ninja'
      });

      final response = await http.get(
        uri,
        headers: {'X-Api-Key': apiKey},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Motorcycle.fromJson(json)).toList();
      } else {
        print('Response error: ${response.body}');
        throw Exception('Failed to load motorcycles: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Motorcycle> getMotorcycleDetail(String make, String model) async {
    try {
      final uri = Uri.parse('$baseUrl/motorcycles')
          .replace(queryParameters: {'make': make, 'model': model});

      final response = await http.get(
        uri,
        headers: {'X-Api-Key': apiKey},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        if (data.isNotEmpty) {
          return Motorcycle.fromJson(data.first);
        } else {
          throw Exception('Motorcycle not found');
        }
      } else {
        throw Exception('Failed to load motorcycle detail');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

class Article {
  final int id;
  final String title;
  final String imageUrl;
  final String content;
  final String date;

  Article({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.content,
    required this.date,
  });
}
