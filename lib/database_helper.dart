import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'cashio.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute('''CREATE TABLE usuarios (
        id_usuario INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        nombre TEXT NOT NULL,
        primer_apellido TEXT NOT NULL,
        segundo_apellido TEXT
      )''');
    });
  }

  // Método para insertar un nuevo usuario
  Future<void> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    await db.insert('usuarios', user, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Método para buscar un usuario por correo
  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.query(
      'usuarios',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }
}
