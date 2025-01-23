import 'package:todo_mobile/data/data_providers/todo_api_provider.dart';
// import 'package:todo_mobile/data/models/todo.dart';
import 'package:todo_mobile/data/models/todo_model.dart';

class TodoRepository {
  final TodoApiProvider apiProvider;

  TodoRepository({required this.apiProvider});

  Future<List<Todo>> getTodos() async {
    return await apiProvider.fetchTodos();
  }

  Future<Todo> getTodoById(String id) async {
    return await apiProvider.fetchTodoById(id);
  }

  Future<Todo> createTodo(Todo todo) async {
    return await apiProvider.createTodo(todo);
  }

  Future<Todo> updateTodo(Todo todo) async {
    return await apiProvider.updateTodo(todo);
  }

  Future<void> deleteTodoById(String id) async {
    await apiProvider.deleteTodoById(id);
  }
}
