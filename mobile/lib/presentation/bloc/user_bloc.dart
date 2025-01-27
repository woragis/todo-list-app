import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_mobile/domain/repositories/user_repository.dart';
import 'package:todo_mobile/presentation/bloc/user_state.dart';
import 'package:todo_mobile/presentation/bloc/user_event.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repository;

  UserBloc(this.repository) : super(UserInitialState()) {
    on<UserLoginEvent>(_onLogin);
    on<UserRegisterEvent>(_onRegister);
    on<UserLogoutEvent>(_onLogout);
    on<UserLocalEvent>(_onLocal);
  }

  Future<void> _onLogin(UserLoginEvent event, Emitter<UserState> emit) async {
    try {
      final response = await repository.login(event.user);
      emit(UserLoadedState(token: 'token', user: response));
    } catch (e) {
      emit(UserErrorState(message: "Error on login: $e"));
    }
  }

  Future<void> _onRegister(
      UserRegisterEvent event, Emitter<UserState> emit) async {
    try {
      final response = await repository.register(event.user);
      emit(UserLoadedState(token: 'token', user: response));
    } catch (e) {
      emit(UserErrorState(message: "Error on register: $e"));
    }
  }

  Future<void> _onLogout(UserLogoutEvent event, Emitter<UserState> emit) async {
    try {
      await repository.logout(event.user);
      emit(UserInitialState());
    } catch (e) {
      emit(UserErrorState(message: "Error on register: $e"));
    }
  }

  Future<void> _onLocal(UserLocalEvent event, Emitter<UserState> emit) async {
    try {
      final localUser = await repository.local();
      emit(UserLoadedState(token: '', user: localUser));
    } catch (e) {
      emit(UserErrorState(message: "Error retrieving local user: $e"));
    }
  }
}
