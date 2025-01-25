import 'package:todo_mobile/data/mappers/user_mapper.dart';
import 'package:todo_mobile/data/providers/user_api_provider.dart';
import 'package:todo_mobile/data/providers/user_db_provider.dart';
import 'package:todo_mobile/domain/entities/user_entity.dart';
import 'package:todo_mobile/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserApiProvider apiProvider;
  final UserDbProvider dbProvider;

  UserRepositoryImpl({
    required this.apiProvider,
    required this.dbProvider,
  });

  @override
  Future<UserEntity> login(UserLoginEntity user) async {
    final model = UserLoginMapper.toModel(user);
    final loggedInUser = await apiProvider.login(model);
    return UserMapper.toEntity(loggedInUser);
  }

  @override
  Future<UserEntity> register(UserRegisterEntity user) async {
    final model = UserRegisterMapper.toModel(user);
    final registeredUser = await apiProvider.register(model);
    return UserMapper.toEntity(registeredUser);
  }

  @override
  Future<void> logout(UserEntity user) async {
    final model = UserMapper.toModel(user);
    await dbProvider.logout(model);
  }
}
