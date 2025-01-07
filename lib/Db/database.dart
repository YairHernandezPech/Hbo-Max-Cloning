import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'favorites.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favorites(
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        image TEXT NOT NULL,
        description TEXT NOT NULL
      )
    ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE favorites ADD COLUMN description TEXT NOT NULL DEFAULT ""');
    }
  }

  Future<int> addFavorite(String title, String image, String description) async {
    Database db = await instance.database;
    return await db.insert('favorites', {
      'title': title,
      'image': image,
      'description': description,
    });
  }

  Future<int> removeFavorite(String title) async {
    Database db = await instance.database;
    return await db.delete('favorites', where: 'title = ?', whereArgs: [title]);
  }

  Future<List<Map<String, dynamic>>> getFavorites() async {
    Database db = await instance.database;
    return await db.query('favorites');
  }

  Future<bool> isFavorite(String title) async {
    Database db = await instance.database;
    var result = await db.query('favorites', where: 'title = ?', whereArgs: [title]);
    return result.isNotEmpty;
  }
}
