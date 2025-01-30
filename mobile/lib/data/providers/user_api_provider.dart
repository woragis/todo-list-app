import 'dart:convert';
import 'dart:developer';

import 'package:todo_mobile/data/models/user_model.dart';
import 'package:todo_mobile/data/models/user_response_model.dart';

import 'package:http/http.dart' as http;

class UserApiProvider {
  final String baseUrl;

  UserApiProvider({
    required this.baseUrl,
  });

  Future<UserDataModel> login(UserLoginModel user) async {
    final uri = Uri.parse('$baseUrl/login');
    final response = await http.post(uri, body: json.encode(user.toJson()));
    print("Response data: $response");
    if (response.statusCode == 200) {
      final data = UserResponseModel.fromJson(json.decode(response.body));
      print("Response mapped data: $data");
      return UserDataModel(user: data.data.user, token: data.data.token);
    } else {
      throw Exception("Error on login function");
    }
  }

  Future<UserDataModel> register(UserRegisterModel user) async {
    final uri = Uri.parse('$baseUrl/register');
    final response = await http.post(uri, body: json.encode(user.toJson()));
    if (response.statusCode == 201) {
      final data = UserResponseModel.fromJson(json.decode(response.body));
      return UserDataModel(user: data.data.user, token: data.data.token);
    } else {
      throw Exception("Error on register function");
    }
  }
}
