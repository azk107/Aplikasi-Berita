import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _database;

  DatabaseHelper._instance();

  String userTable = 'user_table';
  String colId = 'id';
  String colEmail = 'email';
  String colPassword = 'password';

  Future<Database?> get db async {
    _database ??= await _initDb();
    return _database;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'user.db');

    final userDb = await openDatabase(path, version: 1, onCreate: _createDb);
    return userDb;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $userTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colEmail TEXT, $colPassword TEXT)',
    );
  }

  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await this.db;
    return await db!.insert(userTable, user);
  }

  Future<Map<String, dynamic>?> getUser(String email) async {
    final db = await this.db;
    final List<Map<String, dynamic>> result = await db!.query(
      userTable,
      where: '$colEmail = ?',
      whereArgs: [email],
    );

    return result.isNotEmpty ? result.first : null;
  }
}
