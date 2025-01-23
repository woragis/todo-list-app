import 'dart:convert';

import 'package:todo_mobile/data/models/todo_model.dart';

import 'package:http/http.dart' as http;

class TodoRepository {
  final String baseUrl = "http://localhost:8080/todos";

  Future<List<Todo>> fetchTodos() async {
    final uri = Uri.parse('$baseUrl/');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> data = json.decode(response.body).data;
      return data.map((raw) => Todo.fromJson(raw)).toList();
    } else {
      throw Exception('Failed to load todo');
    }
  }

  Future<Todo> createTodo(Todo newTodo) async {
    final uri = Uri.parse('$baseUrl/');
    final response = await http.post(uri, body: newTodo.toJson());
    if (response.statusCode == 201) {
      return Todo.fromJson(json.decode(response.body).data);
    } else {
      throw Exception('Failed to load todo');
    }
  }

  Future<Todo> fetchTodoById(String id) async {
    final uri = Uri.parse('$baseUrl/$id');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return Todo.fromJson(json.decode(response.body).data);
    } else {
      throw Exception('Failed to load todo');
    }
  }

  Future<Todo> updateTodo(Todo todo) async {
    String id = todo.id;
    final uri = Uri.parse('$baseUrl/$id');
    final response = await http.put(uri, body: todo.toJson());
    if (response.statusCode == 200) {
      return Todo.fromJson(json.decode(response.body).data);
    } else {
      throw Exception('Failed to load todo');
    }
  }

  Future<bool> deleteTodo(Todo todo) async {
    String id = todo.id;
    final uri = Uri.parse('$baseUrl/$id');
    final response = await http.delete(uri);
    if (response.statusCode == 200) {
      return true;
      // return Todo.fromJson(json.decode(response.body).data);
    } else {
      throw Exception('Failed to delete todo');
    }
  }
}
