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

class AddTodoEvent extends TodoEvent {
  final NewTodo newTodo;

  AddTodoEvent({
    required this.newTodo,
  });
}

class DeleteTodoEvent extends TodoEvent {
  final String todoId;

  DeleteTodoEvent(this.todoId);

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
    on<AddTodoEvent>(_onAddTodo);
    on<DeleteTodoEvent>(_onDeleteTodo);
  }

  Future<void> _onFetchTodos(
      FetchTodosEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    print("Event called");
    try {
      final todos = await repository.getTodos(fromLocal: true);
      emit(TodoLoaded(todos));
    } catch (e) {
      emit(TodoError('Failed to fetch todos: ${e.toString()}'));
    }
  }

  Future<void> _onToggleTodoCompletion(
      ToggleTodoCompletionEvent event, Emitter<TodoState> emit) async {
    try {
      if (state is TodoLoaded) {
        final currentTodos = (state as TodoLoaded).todos;
        final updatedTodos = currentTodos.map((todo) {
          if (todo.id == event.todoId) {
            final updatedTodo = Todo(
              id: todo.id,
              title: todo.title,
              description: todo.description,
              completed: !todo.completed,
              createdAt: todo.createdAt,
              updatedAt: todo.updatedAt,
            );
            repository.updateTodo(updatedTodo); // Sync changes
            return updatedTodo;
          }
          return todo;
        }).toList();

        emit(TodoLoaded(updatedTodos));
      }
    } catch (e) {
      emit(TodoError('Failed to toggle todo completion: ${e.toString()}'));
    }
  }

  Future<void> _onAddTodo(AddTodoEvent event, Emitter<TodoState> emit) async {
    try {
      if (state is TodoLoaded) {
        final currentTodos = (state as TodoLoaded).todos;
        final newTodo = event.newTodo;
        Todo createdTodo = await repository.createTodo(newTodo);
        final updatedTodos = List<Todo>.from(currentTodos)..add(createdTodo);
        emit(TodoLoaded(updatedTodos));
      }
    } catch (e) {
      emit(TodoError('Failed to add todo: ${e.toString()}'));
    }
  }

  Future<void> _onDeleteTodo(
      DeleteTodoEvent event, Emitter<TodoState> emit) async {
    try {
      if (state is TodoLoaded) {
        final currentTodos = (state as TodoLoaded).todos;
        await repository.deleteTodoById(event.todoId); // Delete from repository
        final updatedTodos =
            currentTodos.where((todo) => todo.id != event.todoId).toList();
        emit(TodoLoaded(updatedTodos));
      }
    } catch (e) {
      emit(TodoError('Failed to delete todo: ${e.toString()}'));
    }
  }
}
