class DefaultResponseModel {
  final int status;
  final String message;
  final String? error;

  DefaultResponseModel({
    required this.status,
    required this.message,
    this.error,
  });

  factory DefaultResponseModel.fromJson(Map<String, dynamic> json) {
    return DefaultResponseModel(
      status: json['status'],
      message: json['message'],
      error: json['error'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'error': error,
    };
  }
}
