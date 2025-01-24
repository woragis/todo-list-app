import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo_mobile/data/models/response_models.dart';
// import 'package:todo_mobile/data/models/todo.dart';
import 'package:todo_mobile/data/models/todo_model.dart';

class TodoApiProvider {
  final String baseUrl;

  TodoApiProvider({required this.baseUrl});

  Future<List<Todo>> fetchTodos() async {
    final uri = Uri.parse('$baseUrl/todos/');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      TodosResponseModel data =
          TodosResponseModel.fromJson(json.decode(response.body));
      return data.data;
    } else {
      throw Exception('Failed to fetch todos');
    }
  }

  Future<Todo> fetchTodoById(String id) async {
    final uri = Uri.parse('$baseUrl/todos/$id');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return Todo.fromJson(json.decode(response.body).data);
    } else {
      throw Exception('Failed to fetch todo');
    }
  }

  Future<Todo> createTodo(Todo newTodo) async {
    final uri = Uri.parse('$baseUrl/todos/');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(newTodo.toJson()),
    );
    if (response.statusCode == 201) {
      return Todo.fromJson(json.decode(response.body).data);
    } else {
      throw Exception('Failed to create todo');
    }
  }

  Future<Todo> updateTodo(Todo todo) async {
    final uri = Uri.parse('$baseUrl/todos/${todo.id}');
    final response = await http.put(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(todo.toJson()),
    );
    if (response.statusCode == 200) {
      return Todo.fromJson(json.decode(response.body).data);
    } else {
      throw Exception('Failed to update todo');
    }
  }

  Future<void> deleteTodoById(String id) async {
    final uri = Uri.parse('$baseUrl/todos/$id');
    final response = await http.delete(uri);
    if (response.statusCode != 200) {
      throw Exception('Failed to delete todo');
    }
  }
}
