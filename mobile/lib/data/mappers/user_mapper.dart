import 'package:todo_mobile/data/models/user_model.dart';
import 'package:todo_mobile/domain/entities/user_entity.dart';

class UserMapper {
  static UserEntity toEntity(UserModel user) => UserEntity(
        id: user.id,
        name: user.name,
        email: user.email,
        password: user.password,
        createdAt: user.createdAt,
        updatedAt: user.updatedAt,
      );

  static UserModel toModel(UserEntity user) => UserModel(
        id: user.id,
        name: user.name,
        email: user.email,
        password: user.password,
        createdAt: user.createdAt,
        updatedAt: user.updatedAt,
      );
}

class UserLoginMapper {
  static UserLoginModel toModel(UserLoginEntity user) => UserLoginModel(
        email: user.email,
        password: user.password,
      );
}

class UserRegisterMapper {
  static UserRegisterModel toModel(UserRegisterEntity user) =>
      UserRegisterModel(
        name: user.name,
        email: user.email,
        password: user.password,
      );
}
