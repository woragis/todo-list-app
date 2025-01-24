import 'package:todo_mobile/data/models/todo_model.dart';

class ResponseModel {
  final int status;
  final String message;
  final String? error;
  final List<Todo> data;

  ResponseModel({
    required this.status,
    required this.message,
    this.error,
    required this.data,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      status: json['status'],
      message: json['message'],
      error: json['error'],
      data: (json['data'] as List).map((todo) => Todo.fromJson(todo)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'error': error,
      'data': data.map((todo) => todo.toJson()).toList(),
    };
  }
}

class TodosResponseModel {
  final int status;
  final String message;
  final String? error;
  final List<Todo> data;

  TodosResponseModel({
    required this.status,
    required this.message,
    this.error,
    required this.data,
  });

  factory TodosResponseModel.fromJson(Map<String, dynamic> json) {
    return TodosResponseModel(
      status: json['status'],
      message: json['message'],
      error: json['error'],
      data: (json['data'] as List).map((todo) => Todo.fromJson(todo)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'error': error,
      'data': data.map((todo) => todo.toJson()).toList(),
    };
  }
}

class TodoResponseModel {
  final int status;
  final String message;
  final String? error;
  final Todo data;

  TodoResponseModel({
    required this.status,
    required this.message,
    this.error,
    required this.data,
  });

  // Factory method to parse JSON into a ResponseModel
  factory TodoResponseModel.fromJson(Map<String, dynamic> json) {
    return TodoResponseModel(
      status: json['status'],
      message: json['message'],
      error: json['error'],
      data: json['data'],
    );
  }

  // Convert ResponseModel back to JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'error': error,
      'data': data,
    };
  }
}
