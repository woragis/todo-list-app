// response_model.dart

abstract class ResponseModel<T> {
  final int status;
  final String message;
  final String? error;
  final T data;

  ResponseModel({
    required this.status,
    required this.message,
    this.error,
    required this.data, // Non-nullable data field
  });

  // Convert model back to JSON
  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    return {
      'status': status,
      'message': message,
      'error': error,
      'data': toJsonT(data),
    };
  }
}
