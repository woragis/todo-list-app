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
    await db.insert(tableName, user.toJson());
  }

  Future<void> register(UserRegisterModel user) async {
    await db.insert(tableName, user.toJson());
  }

  Future<void> logout(UserModel user) async {
    await db.delete(tableName, where: 'id = ?', whereArgs: [user.id]);
  }
}
