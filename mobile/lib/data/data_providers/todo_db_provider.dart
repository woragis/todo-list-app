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
    var databaseFactory = databaseFactoryFfi;
    var databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _dbName);
    var db = await databaseFactory.openDatabase(
      path,
      // version: 1,
      // onCreate: _onCreate,
      // onUpgrade: _onUpgrade,
    );
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_tableName (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT,
        completed INTEGER NOT NULL DEFAULT 0
      )
    ''');
    print("Db initialized");
    return db;
  }

  // Create the table(s) on database creation
  // Future<void> _onCreate(Database db, int version) async {
  //   await db.execute();
  // }

  // Handle database upgrades
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      // Add your migration scripts here if needed
    }
  }

  Future<List<Todo>> getTodos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('todos');
    return List.generate(
      maps.length,
      (i) => Todo.fromJson(maps[i]),
    );
  }

  Future<Todo> getTodoById(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'todos',
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
      'todos',
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
