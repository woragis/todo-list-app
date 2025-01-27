import 'package:todo_mobile/data/models/todo_model.dart';

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

  factory TodoResponseModel.fromJson(Map<String, dynamic> json) {
    return TodoResponseModel(
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
