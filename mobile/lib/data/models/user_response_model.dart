import 'package:todo_mobile/data/models/user_model.dart';

class UserResponseData {
  final String token;
  final UserModel user;

  UserResponseData({
    required this.token,
    required this.user,
  });
}

class UserResponseModel {
  final int status;
  final String message;
  final String? error;
  final UserResponseData data;

  UserResponseModel({
    required this.status,
    required this.message,
    this.error,
    required this.data,
  });

  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
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
