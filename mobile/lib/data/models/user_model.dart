class UserDataModel {
  UserModel user;
  String token;

  UserDataModel({
    required this.user,
    required this.token,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
        user: json['user'],
        token: json['token'],
      );

  Map<String, dynamic> toJson() => {
        'user': user,
        'token': token,
      };
}

class UserModel {
  String id;
  String name;
  String email;
  String password;
  DateTime createdAt;
  DateTime updatedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        password: json['password'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };
}

class UserLoginModel {
  String email;
  String password;

  UserLoginModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}

class UserRegisterModel {
  String name;
  String email;
  String password;

  UserRegisterModel({
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
      };
}
