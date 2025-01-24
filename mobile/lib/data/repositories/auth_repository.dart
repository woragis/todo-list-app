import 'package:todo_mobile/data/providers/auth_api_provider.dart';
import 'package:todo_mobile/data/providers/auth_db_provider.dart';
import 'package:todo_mobile/data/models/auth_model.dart';
import 'package:todo_mobile/data/models/response_models.dart';

class AuthRepository {
  final AuthApiProvider apiProvider;
  final AuthDbProvider dbProvider;

  AuthRepository({
    required this.apiProvider,
    required this.dbProvider,
  });

  Future<AuthResponseData> login({required Login user}) async {
    AuthResponseData loggedInUser = await apiProvider.loginUser(user);
    // await dbProvider.
    return loggedInUser;
  }

  Future<AuthResponseData> register({required Register user}) async {
    AuthResponseData createdTodo = await apiProvider.registerUser(user);
    await dbProvider.createUser(createdTodo.user);
    return createdTodo;
  }

  Future<void> logout(User user) async {
    // Clear user data from local storage
    await dbProvider.deleteUser(user);
  }

  Future<User?> loadUserFromStorage(User user) async {
    // Load user from local storage
    final localUser = await dbProvider.getUser(user);
    return localUser;
  }

  // Future<void> _saveUserToStorage(User user) async {
  //   await dbProvider.insert("user", user.toJson(),
  //       conflictAlgorithm: ConflictAlgorithm.replace);
  // }
}
