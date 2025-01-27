import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_mobile/domain/repositories/todo_repository.dart';
import 'package:todo_mobile/presentation/bloc/todo_event.dart';
import 'package:todo_mobile/presentation/bloc/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;

  TodoBloc(this.todoRepository) : super(TodoInitialState()) {
    on<FetchTodosEvent>(_onFetchTodos);
    on<TodoCreateEvent>(_onCreateTodos);
    on<TodoUpdateEvent>(_onUpdateTodos);
    on<TodoDeleteEvent>(_onDeleteTodos);
  }

  Future<void> _onFetchTodos(event, emit) async {
    emit(TodoLoadingState());
    try {
      final todos = await todoRepository.fetchTodos();
      emit(TodoLoadedState(todos));
    } catch (e) {
      emit(TodoErrorState(e.toString()));
    }
  }

  Future<void> _onCreateTodos(event, emit) async {
    try {
      await todoRepository.createTodo(event.todo);
      add(FetchTodosEvent()); // Refresh the todo list
    } catch (e) {
      emit(TodoErrorState(e.toString()));
    }
  }

  Future<void> _onUpdateTodos(event, emit) async {
    try {
      await todoRepository.updateTodo(event.todo);
      add(FetchTodosEvent()); // Refresh the todo list
    } catch (e) {
      emit(TodoErrorState(e.toString()));
    }
  }

  Future<void> _onDeleteTodos(event, emit) async {
    try {
      await todoRepository.deleteTodoById(event.id);
      add(FetchTodosEvent()); // Refresh the todo list
    } catch (e) {
      emit(TodoErrorState(e.toString()));
    }
  }
}
