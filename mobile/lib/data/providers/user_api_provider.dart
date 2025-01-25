import 'dart:convert';

import 'package:todo_mobile/data/models/user_model.dart';
import 'package:todo_mobile/data/models/user_response_model.dart';

import 'package:http/http.dart' as http;

class UserApiProvider {
  final String baseUrl;

  UserApiProvider({
    required this.baseUrl,
  });

  Future<UserModel> login(UserLoginModel user) async {
    final uri = Uri.parse('$baseUrl/login');
    final response = await http.post(uri, body: json.encode(user.toJson()));
    if (response.statusCode == 200) {
      final data = UserResponseModel.fromJson(json.decode(response.body));
      return data.data.user;
    } else {
      throw Exception("Error on login function");
    }
  }

  Future<UserModel> register(UserRegisterModel user) async {
    final uri = Uri.parse('$baseUrl/register');
    final response = await http.post(uri, body: json.encode(user.toJson()));
    if (response.statusCode == 201) {
      final data = UserResponseModel.fromJson(json.decode(response.body));
      return data.data.user;
    } else {
      throw Exception("Error on register function");
    }
  }
}
