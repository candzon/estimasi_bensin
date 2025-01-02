// database_helper.dart
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/predict.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'predicts.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE predicts(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        jarakTempuh REAL,
        bahanBakar TEXT,
        merkKendaraan TEXT,
        estimasiBensin REAL,
        totalBiaya REAL,
        photo TEXT
      )
    ''');
  }

  Future<int> insertPredict(Predict predict) async {
    Database db = await database;
    Map<String, dynamic> data = predict.toJson();
    data.remove('id'); // Remove the id field to let SQLite auto-increment it
    return await db.insert('predicts', data);
  }

  Future<List<Predict>> getPredicts() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('predicts');
    return List.generate(maps.length, (i) {
      return Predict.fromJson(maps[i]);
    });
  }

  Future<int> updatePredict(Predict predict) async {
    Database db = await database;
    return await db.update(
      'predicts',
      predict.toJson(),
      where: 'id = ?',
      whereArgs: [predict.id],
    );
  }

  Future<int> deletePredict(int id) async {
    Database db = await database;
    return await db.delete(
      'predicts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
