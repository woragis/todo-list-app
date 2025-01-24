import 'package:path/path.dart' show join;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
// import 'package:todo_mobile/data/models/todo_model.dart';
import 'package:todo_mobile/data/models/todo_model.dart';

class TodoDbProvider {
  static const String _tableName = 'todos';
  static const String _dbName = 'todo_app.db';

  static final TodoDbProvider _instance = TodoDbProvider._internal();
  // factory TodoDbProvider() => _instance;

  static Database? _database;
  TodoDbProvider._internal();

  factory TodoDbProvider() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // databaseFactory = databaseFactoryFfi;
    var databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _dbName);
    var db = await databaseFactory.openDatabase(path);
    print("Db initialized");
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_tableName (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT,
        completed INTEGER NOT NULL DEFAULT 0
      )
    ''');
    print("Table $_tableName created");
    return db;
  }

  Future<void> saveTodos(List<Todo> todos) async {
    final db = await database;
    for (var todo in todos) {
      await db.insert(
        _tableName,
        todo.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Todo>> getTodos() async {
    print("Todo_db_provider function: getTodos");
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(
      maps.length,
      (i) => Todo.fromJson(maps[i]),
    );
  }

  Future<Todo> getTodoById(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Todo.fromJson(maps.first);
    } else {
      throw Exception('Todo not found');
    }
  }

  Future<void> createTodo(Todo todo) async {
    final db = await database;
    await db.insert(
      _tableName,
      todo.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateTodo(Todo todo) async {
    final db = await database;
    await db.update(
      'todos',
      todo.toJson(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<void> deleteTodoById(String id) async {
    final db = await database;
    await db.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
