import 'package:equatable/equatable.dart';
import 'package:todo_mobile/domain/entities/todo_entity.dart';

abstract class TodoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TodoInitialState extends TodoState {
  // test to see if is a good practice to leave it here since the beginning
  static List<TodoEntity?> todos = [];
}

class TodoLoadingState extends TodoState {}

class TodoLoadedState extends TodoState {
  final List<TodoEntity> todos;

  TodoLoadedState(this.todos);

  @override
  List<Object?> get props => [todos];
}

class TodoErrorState extends TodoState {
  final String message;

  TodoErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
