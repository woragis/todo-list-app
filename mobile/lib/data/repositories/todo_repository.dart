import 'package:todo_mobile/data/data_providers/todo_api_provider.dart';
import 'package:todo_mobile/data/data_providers/todo_db_provider.dart';
import 'package:todo_mobile/data/models/todo_model.dart';

class TodoRepository {
  final TodoApiProvider apiProvider;
  final TodoDbProvider dbProvider;

  TodoRepository({
    required this.apiProvider,
    required this.dbProvider,
  });

  Future<List<Todo>> getTodos({bool fromLocal = false}) async {
    if (fromLocal) {
      return await dbProvider.getTodos();
    } else {
      final todos = await apiProvider.fetchTodos();
      for (var todo in todos) {
        await dbProvider.createTodo(todo); // Sync local database
      }
      return todos;
    }
  }

  Future<Todo> getTodoById(String id, {bool fromLocal = true}) async {
    if (fromLocal) {
      return await dbProvider.getTodoById(id);
    } else {
      final todo = await apiProvider.fetchTodoById(id);
      await dbProvider.createTodo(todo); // Sync local database
      return todo;
    }
  }

  Future<void> createTodo(Todo todo) async {
    await dbProvider.createTodo(todo);
    await apiProvider.createTodo(todo);
  }

  Future<void> updateTodo(Todo todo) async {
    await dbProvider.updateTodo(todo);
    await apiProvider.updateTodo(todo);
  }

  Future<void> deleteTodoById(String id) async {
    await dbProvider.deleteTodoById(id);
    await apiProvider.deleteTodoById(id);
  }
}
