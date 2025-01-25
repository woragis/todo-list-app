import 'dart:convert';

import 'package:todo_mobile/data/models/user_model.dart';
import 'package:todo_mobile/data/models/response_models.dart';

import 'package:http/http.dart' as http;

class AuthApiProvider {
  final String baseUrl;

  AuthApiProvider({required this.baseUrl});

  Future<AuthResponseData> registerUser(UserRegisterModel user) async {
    final uri = Uri.parse('$baseUrl/register');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user.toJson()),
    );
    if (response.statusCode == 201) {
      AuthResponseModel data =
          AuthResponseModel.fromJson(json.decode(response.body));
      return data.data;
    } else {
      throw Exception('Failed to register user');
    }
  }

  Future<AuthResponseData> loginUser(UserLoginModel user) async {
    final uri = Uri.parse('$baseUrl/login');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user.toJson()),
    );
    if (response.statusCode == 200) {
      AuthResponseModel data =
          AuthResponseModel.fromJson(json.decode(response.body));
      return data.data;
    } else {
      throw Exception('Failed to login user');
    }
  }
}
