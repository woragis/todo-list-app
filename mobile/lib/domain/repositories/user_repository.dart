import 'package:todo_mobile/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<UserDataEntity> login(UserLoginEntity user);
  Future<UserDataEntity> register(UserRegisterEntity user);
  Future<UserDataEntity> local();
  Future<void> logout(UserEntity user);
}
