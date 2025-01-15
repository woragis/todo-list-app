import 'todo_model.dart'; // Make sure to import the Todo model

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

  // Factory constructor to create an instance from JSON
  factory TodoResponseModel.fromJson(Map<String, dynamic> json) {
    return TodoResponseModel(
      status: json['status'] as int,
      message: json['message'] as String,
      error: json['error'] as String?,
      data: Todo.fromJson(
          json['data'] as Map<String, dynamic>), // Deserialize the single Todo
    );
  }

  // Method to convert the model back to JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'error': error,
      'data': data.toJson(), // Serialize the single Todo
    };
  }
}
