import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;

  DatabaseService._internal();
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'calculations.db');
    return await openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE calculations (
            id INTEGER PRIMARY KEY,
            fileType TEXT,
            discretization REAL,
            bitDepth REAL,
            duration REAL,
            fileSizeInBits REAL,
            fileSizeInBytes REAL,
            fileSizeInKB REAL,
            fileSizeInMB REAL
          )
        ''');
      },
      version: 1,
    );
  }

  Future<void> insertCalculation(Map<String, dynamic> data) async {
    final db = await database;
    await db.insert('calculations', data);
  }

  Future<List<Map<String, dynamic>>> getCalculations() async {
    final db = await database;
    return await db.query('calculations', orderBy: "id DESC");
  }
}
