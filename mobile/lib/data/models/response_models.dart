import 'package:todo_mobile/data/models/user_model.dart';
import 'package:todo_mobile/data/models/todo_model.dart';

class ResponseModel {
  final int status;
  final String message;
  final String? error;
  final List<TodoModel> data;

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
      data: (json['data'] as List)
          .map((todo) => TodoModel.fromJson(todo))
          .toList(),
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
  final List<TodoModel> data;

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
      data: (json['data'] as List)
          .map((todo) => TodoModel.fromJson(todo))
          .toList(),
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
  final TodoModel data;

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

class AuthResponseData {
  final String token;
  final UserModel user;

  AuthResponseData({
    required this.token,
    required this.user,
  });
}

class AuthResponseModel {
  final int status;
  final String message;
  final String? error;
  final AuthResponseData data;

  AuthResponseModel({
    required this.status,
    required this.message,
    this.error,
    required this.data,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      status: json['status'],
      message: json['message'],
      error: json['error'],
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'error': error,
      'data': data,
    };
  }
}
