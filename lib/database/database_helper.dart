import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB('taskflow.db');
    return _database!;
  }
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();

    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // Création des tables
  Future _createDB(Database db, int version) async {
    // Table utilisateurs
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL
      )
    ''');
    // Table tâches
    await db.execute('''
      CREATE TABLE tasks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        category TEXT,
        priority TEXT,
        date TEXT,
        status INTEGER DEFAULT 0,
        user_id INTEGER,
        FOREIGN KEY (user_id) REFERENCES users(id)
      )
    ''');
  }
  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
