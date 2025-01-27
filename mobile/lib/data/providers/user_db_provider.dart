import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:todo_mobile/data/models/user_model.dart';

class UserDbProvider {
  final Database db;
  final String tableName;

  UserDbProvider({
    required this.db,
    required this.tableName,
  });

  Future<void> login(UserLoginModel user) async {
    await db.delete(tableName);
    await db.insert(tableName, user.toJson());
  }

  Future<void> register(UserRegisterModel user) async {
    await db.delete(tableName);
    await db.insert(tableName, user.toJson());
  }

  Future<UserModel> local() async {
    final rows = await db.query(tableName, limit: 1);
    return UserModel.fromJson(rows[0]);
  }

  Future<void> logout(UserModel user) async {
    await db.delete(tableName);
  }
}
