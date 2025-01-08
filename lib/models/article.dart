import 'package:intl/intl.dart';

class Article {
  final int id;
  final String title;
  final String body;
  final String photo;
  final DateTime createdAt;
  final DateTime updatedAt;

  Article({
    required this.id,
    required this.title,
    required this.body,
    required this.photo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      photo: json['photo'],
      createdAt: DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'").parse(json['createdAt']),
      updatedAt: DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'").parse(json['updatedAt']),
    );
  }
}
