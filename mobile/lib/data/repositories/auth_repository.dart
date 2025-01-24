import 'package:todo_mobile/data/models/auth_model.dart';
import 'package:sqflite/sqflite.dart';

class AuthRepository {
  final Database database;

  AuthRepository({required this.database});

  Future<User> login({required String email, required String password}) async {
    // Replace this with your API call
    final response = await Future.delayed(
      Duration(seconds: 2),
      () => {
        "id": "1",
        "name": "Test User",
        "email": email,
        "password": password,
        "created_at": "2023-01-01",
        "updated_at": "2023-01-01"
      },
    );

    final user = User.fromJson(response);
    await _saveUserToStorage(user);
    return user;
  }

  Future<User> register({
    required String name,
    required String email,
    required String password,
  }) async {
    // Replace this with your API call
    final response = await Future.delayed(
      Duration(seconds: 2),
      () => {
        "id": "1",
        "name": name,
        "email": email,
        "password": password,
        "created_at": "2023-01-01",
        "updated_at": "2023-01-01"
      },
    );

    final user = User.fromJson(response);
    await _saveUserToStorage(user);
    return user;
  }

  Future<void> logout() async {
    // Clear user data from local storage
    await database.delete("user");
  }

  Future<User?> loadUserFromStorage() async {
    // Load user from local storage
    final userMap = await database.query("user", limit: 1);
    if (userMap.isNotEmpty) {
      return User.fromJson(userMap.first);
    }
    return null;
  }

  Future<void> _saveUserToStorage(User user) async {
    await database.insert("user", user.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
