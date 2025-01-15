import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/todo_model.dart';
import '../models/todos_response_model.dart';
import '../models/todo_response_model.dart';

class TodoService {
  static const String baseUrl = 'http://localhost:8080/todos/';

  Future<TodosResponseModel> fetchTodos() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        // Ensure data field is not null
        if (jsonData['data'] != null) {
          return TodosResponseModel.fromJson(jsonData);
        } else {
          throw Exception('No data field found in the response.');
        }
      } else {
        throw Exception(
            'Failed to load todos. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching todos: $e');
    }
  }

  // Fetch a single todo by ID
  Future<TodoResponseModel> fetchTodoById(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$id'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return TodoResponseModel.fromJson(jsonData);
      } else {
        throw Exception(
            'Failed to fetch todo. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching todo: $e');
    }
  }

  // Create a new todo
  Future<TodoResponseModel> createTodo(Todo todo) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(todo.toJson()),
      );

      if (response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        return TodoResponseModel.fromJson(jsonData);
      } else {
        throw Exception(
            'Failed to create todo. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating todo: $e');
    }
  }

// Update an existing todo by ID
  Future<TodoResponseModel> updateTodo(int id, Todo todo) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(todo.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        return TodoResponseModel.fromJson(jsonData);
      } else {
        throw Exception(
            'Failed to update todo. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating todo: $e');
    }
  }

  // Delete a todo by ID
  Future<void> deleteTodo(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$id'));

      if (response.statusCode != 204) {
        throw Exception(
            'Failed to delete todo. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error deleting todo: $e');
    }
  }
}
