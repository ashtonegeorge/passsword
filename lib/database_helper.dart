import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'sword_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = p.join(await getDatabasesPath(), 'swords.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE swords(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        type TEXT,
        name TEXT,
        description TEXT,
        username TEXT,
        password TEXT,
        securityPhrase TEXT,
        sheath TEXT
      )
    ''');
  }

  Future<int> insertSword(Sword sword) async {
    Database db = await database;
    return await db.insert('swords', sword.toMap());
  }

  Future<List<Sword>> getSwords() async {
    Database db = await database;
    List<Map<String, dynamic>> swords = await db.query('swords');
    return List.generate(swords.length, (i) {
      return Sword.fromMap(swords[i]);
    });
  }

  Future<int> updateSword(Sword sword) async {
    Database db = await database;
    return await db.update(
      'swords',
      sword.toMap(),
      where: 'id = ?',
      whereArgs: [sword.id],
    );
  }

  Future<int> deleteSword(int id) async {
    Database db = await database;
    return await db.delete(
      'swords',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}