import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_mobile/data/models/todo_model.dart';
import 'package:todo_mobile/data/repositories/todo_repository.dart';

// Events
abstract class TodoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchTodosEvent extends TodoEvent {}

class ToggleTodoCompletionEvent extends TodoEvent {
  final String todoId;

  ToggleTodoCompletionEvent(this.todoId);

  @override
  List<Object?> get props => [todoId];
}

// States
abstract class TodoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<Todo> todos;

  TodoLoaded(this.todos);

  @override
  List<Object?> get props => [todos];
}

class TodoError extends TodoState {
  final String message;

  TodoError(this.message);

  @override
  List<Object?> get props => [message];
}

// Bloc
class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository repository;

  TodoBloc({required this.repository}) : super(TodoLoading()) {
    on<FetchTodosEvent>(_onFetchTodos);
    on<ToggleTodoCompletionEvent>(_onToggleTodoCompletion);
  }

  Future<void> _onFetchTodos(
      FetchTodosEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    try {
      final todos = await repository.getTodos(fromLocal: true);
      emit(TodoLoaded(todos));
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  Future<void> _onToggleTodoCompletion(
      ToggleTodoCompletionEvent event, Emitter<TodoState> emit) async {
    try {
      if (state is TodoLoaded) {
        final currentTodos = (state as TodoLoaded).todos;
        final updatedTodos = currentTodos.map((todo) {
          if (todo.id == event.todoId) {
            return Todo(
              id: todo.id,
              title: todo.title,
              description: todo.description,
              completed: !todo.completed,
            );
          }
          return todo;
        }).toList();

        emit(TodoLoaded(updatedTodos));
      }
    } catch (e) {
      emit(TodoError('Failed to toggle todo completion'));
    }
  }
}
