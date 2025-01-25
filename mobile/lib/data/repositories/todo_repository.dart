import 'package:todo_mobile/data/providers/todo_api_provider.dart';
import 'package:todo_mobile/data/providers/todo_db_provider.dart';
import 'package:todo_mobile/data/models/todo_model.dart';

class TodoRepository {
  final TodoApiProvider apiProvider;
  final TodoDbProvider dbProvider;

  TodoRepository({
    required this.apiProvider,
    required this.dbProvider,
  });

  Future<List<TodoModel>> getTodos({bool fromLocal = false}) async {
    try {
      print("Fetching api");
      final todos = await apiProvider.fetchTodos();
      await dbProvider.saveTodos(todos);
      return todos;
    } catch (e) {
      return await dbProvider.getTodos();
    }
  }

  Future<TodoModel> getTodoById(String id, {bool fromLocal = true}) async {
    if (fromLocal) {
      return await dbProvider.getTodoById(id);
    } else {
      final todo = await apiProvider.fetchTodoById(id);
      await dbProvider.createTodo(todo); // Sync local database
      return todo;
    }
  }

  Future<TodoModel> createTodo(NewTodo todo) async {
    TodoModel createdTodo = await apiProvider.createTodo(todo);
    await dbProvider.createTodo(createdTodo);
    return createdTodo;
  }

  Future<void> updateTodo(TodoModel todo) async {
    await dbProvider.updateTodo(todo);
    await apiProvider.updateTodo(todo);
  }

  Future<void> deleteTodoById(String id) async {
    await dbProvider.deleteTodoById(id);
    await apiProvider.deleteTodoById(id);
  }
}
