import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class Todo {
  String id;
  String title;
  String description;
  bool completed;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    this.completed = false,
  });

  // Toggle the completion status
  Todo toggleCompleted() {
    return Todo(
      id: id,
      title: title,
      description: description,
      completed: !completed,
    );
  }

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        completed: json['completed'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "completed": completed,
      };
}

Future<Todo> fetchTodoById(String id) async {
  final uri = Uri.parse('http://localhost:8080/todos/$id');
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    return Todo.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load todo');
  }
}

Future<Todo> createTodo(Todo newTodo) async {
  final uri = Uri.parse('http://localhost:8080/todos/');
  final response = await http.post(uri, body: newTodo.toJson());
  if (response.statusCode == 201) {
    return Todo.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load todo');
  }
}

Future<Todo> updateTodo(Todo todo) async {
  final uri = Uri.parse('http://localhost:8080/todos/');
  final response = await http.put(uri, body: todo.toJson());
  if (response.statusCode == 200) {
    return Todo.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load todo');
  }
}

Future<Todo?>? deleteTodo(Todo todo) async {
  String id = todo.id;
  final uri = Uri.parse('http://localhost:8080/todos/$id');
  final response = await http.delete(uri);
  if (response.statusCode == 200) {
    return null;
    // return Todo.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to delete todo');
  }
}

class TodoCubit extends Cubit<List<Todo>> {
  TodoCubit() : super([]);

  // Initialize todos
  // For testing only
  // Because of the lack of local database and lack of api connection currently
  void initializeTodos(List<Todo> todos) {
    emit(todos);
  }

  // Add a new note
  void addNote(String id, String title, String description) {
    final newTodo = Todo(id: id, title: title, description: description);
    emit([...state, newTodo]); // Add new Todo to the list
  }

  // Toggle completion status of a Todo
  void toggleCompleted(String id) {
    final updatedTodos = state.map((todo) {
      if (todo.id == id) {
        return todo.toggleCompleted(); // Toggle completion for matching note
      }
      return todo; // Leave other Todos unchanged
    }).toList();

    emit(updatedTodos); // Emit updated state
  }

  // Delete a note (Todo)
  void deleteNote(String id) {
    final updatedTodos = state.where((todo) => todo.id != id).toList();
    emit(updatedTodos); // Emit new state without the deleted Todo
  }
}
