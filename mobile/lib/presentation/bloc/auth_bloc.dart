import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_mobile/data/models/auth_model.dart';
import 'package:todo_mobile/data/repositories/auth_repository.dart';

/// EVENTS
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginEvent extends AuthEvent {
  final Login user;

  const LoginEvent({
    required this.user,
  });

  @override
  List<Object?> get props => [user.email, user.password];
}

class RegisterEvent extends AuthEvent {
  final Register user;

  const RegisterEvent({
    required this.user,
  });

  @override
  List<Object?> get props => [user.name, user.email, user.password];
}

class LogoutEvent extends AuthEvent {
  final User user;

  const LogoutEvent({
    required this.user,
  });

  @override
  List<Object?> get props => [user];
}

class LoadAuthEvent extends AuthEvent {}

/// STATES
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthAuthenticatedState extends AuthState {
  final String token;
  final User user;

  const AuthAuthenticatedState({
    required this.token,
    required this.user,
  });

  @override
  List<Object?> get props => [token, user];
}

class AuthUnauthenticatedState extends AuthState {}

class AuthErrorState extends AuthState {
  final String message;

  const AuthErrorState({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

/// BLOC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc({
    required this.repository,
  }) : super(AuthInitialState()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<LogoutEvent>(_onLogout);
    on<LoadAuthEvent>(_onLoadAuth);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    try {
      final response = await repository.login(user: event.user);
      emit(AuthAuthenticatedState(token: response.token, user: response.user));
    } catch (e) {
      emit(AuthErrorState(message: "Error on login with bloc: $e"));
    }
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    try {
      final response = await repository.register(user: event.user);
      emit(AuthAuthenticatedState(token: response.token, user: response.user));
    } catch (e) {
      emit(AuthErrorState(message: "Error on register with bloc: $e"));
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    try {
      await repository.logout(event.user);
      emit(AuthUnauthenticatedState());
    } catch (e) {
      emit(AuthErrorState(message: "Error on lgout with bloc: $e"));
    }
  }

  Future<void> _onLoadAuth(LoadAuthEvent event, Emitter<AuthState> emit) async {
    // try {
    //   emit(LoadAuthEvent());
    // } catch (e) {
    //   throw Exception("Error on logout with bloc");
    // }
  }
}
