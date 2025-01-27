import 'package:equatable/equatable.dart';
import 'package:todo_mobile/domain/entities/user_entity.dart';

abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  final String token;
  final UserEntity user;

  UserLoadedState({
    required this.token,
    required this.user,
  });

  @override
  List<Object?> get props => [token, user];
}

class UserErrorState extends UserState {
  final String message;

  UserErrorState({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
