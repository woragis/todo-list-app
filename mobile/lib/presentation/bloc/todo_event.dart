import 'package:equatable/equatable.dart';
import 'package:todo_mobile/domain/entities/todo_entity.dart';

abstract class TodoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchTodosEvent extends TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final NewTodoEntity todo;

  AddTodoEvent(this.todo);

  @override
  List<Object?> get props => [todo];
}

class UpdateTodoEvent extends TodoEvent {
  final TodoEntity todo;

  UpdateTodoEvent(this.todo);

  @override
  List<Object?> get props => [todo];
}

class DeleteTodoEvent extends TodoEvent {
  final String id;

  DeleteTodoEvent(this.id);

  @override
  List<Object?> get props => [id];
}
