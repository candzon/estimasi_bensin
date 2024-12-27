// api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/motorcycle.dart';
import '../models/predict.dart';
import '../models/article.dart';

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
    try {
      final response = await http.get(
        Uri.parse('https://predict-fuel-3010998af052.herokuapp.com/articles'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Article.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load articles');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Article> getArticleById(int id) async {
    try {
      final response = await http.get(
        Uri.parse('https://predict-fuel-3010998af052.herokuapp.com/articles/$id'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return Article.fromJson(json.decode(response.body));
      } else {
        throw Exception('Article not found');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
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