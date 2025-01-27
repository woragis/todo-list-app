import 'package:equatable/equatable.dart';
import 'package:todo_mobile/domain/entities/user_entity.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserLoginEvent extends UserEvent {
  final UserLoginEntity user;

  UserLoginEvent(this.user);

  @override
  List<Object?> get props => [user];
}

class UserRegisterEvent extends UserEvent {
  final UserRegisterEntity user;

  UserRegisterEvent(this.user);

  @override
  List<Object?> get props => [user];
}

class UserLocalEvent extends UserEvent {}

class UserLogoutEvent extends UserEvent {
  final UserEntity user;

  UserLogoutEvent(this.user);

  @override
  List<Object?> get props => [user];
}
