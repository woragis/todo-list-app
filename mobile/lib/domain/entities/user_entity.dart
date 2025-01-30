class UserEntity {
  final String id;
  final String name;
  final String email;
  final String password;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
  });
}

class UserDataEntity {
  final UserEntity user;
  final String token;

  UserDataEntity({
    required this.user,
    required this.token,
  });
}

class UserRegisterEntity {
  final String name;
  final String email;
  final String password;

  UserRegisterEntity({
    required this.name,
    required this.email,
    required this.password,
  });
}

class UserLoginEntity {
  final String email;
  final String password;

  UserLoginEntity({
    required this.email,
    required this.password,
  });
}
