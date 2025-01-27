import 'package:todo_mobile/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> login(UserLoginEntity user);
  Future<UserEntity> register(UserRegisterEntity user);
  Future<UserEntity> local();
  Future<void> logout(UserEntity user);
}
