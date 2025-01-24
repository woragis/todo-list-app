import 'dart:developer';

import 'package:todo_mobile/data/models/auth_model.dart';

import 'package:path/path.dart' show join;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class AuthDbProvider {
  static const String _tableName = 'users';
  static const String _dbName = 'todo_app.db';

  static final AuthDbProvider _instance = AuthDbProvider._internal();

  static Database? _database;
  AuthDbProvider._internal();

  factory AuthDbProvider() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String databasesPath = await getDatabasesPath();
    final String path = join(databasesPath, _dbName);

    Database db = await databaseFactory.openDatabase(path);
    log("Auth db opened");

    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_tableName (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        email TEXT NOT NULL,
        password TEXT NOT NULL
      )
    ''');
    log("Table $_tableName created on database: $_dbName");

    return db;
  }

  // Future<void> saveTodos(List<Todo> todos) async {
  //   final db = await database;
  //   for (var todo in todos) {
  //     await db.insert(
  //       _tableName,
  //       todo.toJson(),
  //       conflictAlgorithm: ConflictAlgorithm.replace,
  //     );
  //   }
  // }

  // Future<List<Todo>> getTodos() async {
  //   log("Todo_db_provider function: getTodos");
  //   final db = await database;
  //   final List<Map<String, dynamic>> maps = await db.query(_tableName);
  //   return List.generate(
  //     maps.length,
  //     (i) => Todo.fromJson(maps[i]),
  //   );
  // }

  Future<User> getUser(User user) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [user.id],
    );

    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    } else {
      throw Exception('User not found');
    }
  }

  Future<void> createUser(User user) async {
    final db = await database;
    await db.insert(
      _tableName,
      user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateUser(User user) async {
    final db = await database;
    await db.update(
      _tableName,
      user.toJson(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<void> deleteUser(User user) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }
}
