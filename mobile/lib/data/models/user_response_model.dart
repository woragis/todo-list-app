import 'package:todo_mobile/data/models/user_model.dart';

class UserResponseDataModel {
  final String token;
  final UserModel user;

  UserResponseDataModel({
    required this.token,
    required this.user,
  });

  factory UserResponseDataModel.fromJson(Map<String, dynamic> json) {
    return UserResponseDataModel(
      token: json['token'],
      user: json['user'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'user': user,
    };
  }
}

class UserResponseModel {
  final int status;
  final String message;
  final String? error;
  final UserResponseDataModel data;

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
      data: UserResponseDataModel.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'error': error,
      'data': data.toJson(),
    };
  }
}
