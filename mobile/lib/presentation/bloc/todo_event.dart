import 'package:equatable/equatable.dart';
import 'package:todo_mobile/domain/entities/todo_entity.dart';

abstract class TodoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchTodosEvent extends TodoEvent {}

class TodoCreateEvent extends TodoEvent {
  final NewTodoEntity todo;

  TodoCreateEvent(this.todo);

  @override
  List<Object?> get props => [todo];
}

class TodoUpdateEvent extends TodoEvent {
  final TodoEntity todo;

  TodoUpdateEvent(this.todo);

  @override
  List<Object?> get props => [todo];
}

class TodoDeleteEvent extends TodoEvent {
  final String id;

  TodoDeleteEvent(this.id);

  @override
  List<Object?> get props => [id];
}
