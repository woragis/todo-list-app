// todos_response_model.dart

import 'response_model.dart';
import 'todo_model.dart'; // Make sure you have a Todo model class

class TodosResponseModel extends ResponseModel<List<Todo>> {
  TodosResponseModel({
    required int status,
    required String message,
    String? error,
    required List<Todo> data,
  }) : super(status: status, message: message, error: error, data: data);

  factory TodosResponseModel.fromJson(Map<String, dynamic> json) {
    return TodosResponseModel(
      status: json['status'] as int,
      message: json['message'] as String,
      error: json['error'] as String?,
      data: (json['data'] as List<dynamic>)
          .map((e) =>
              Todo.fromJson(e as Map<String, dynamic>)) // Deserialize data
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson(
      Map<String, dynamic> Function(List<Todo>) toJsonT) {
    return super.toJson(
      (data) => data.map((todo) => todo.toJson()).toList()
          as Map<String, dynamic>, // Map each Todo to a JSON object
    );
  }
}
