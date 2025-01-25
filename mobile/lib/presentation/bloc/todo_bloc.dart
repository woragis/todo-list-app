import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_mobile/domain/repositories/todo_repository.dart';
import 'package:todo_mobile/presentation/bloc/todo_event.dart';
import 'package:todo_mobile/presentation/bloc/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;

  TodoBloc(this.todoRepository) : super(TodoInitial()) {
    // Fetch Todos
    on<FetchTodosEvent>((event, emit) async {
      emit(TodoLoading());
      try {
        final todos = await todoRepository.fetchTodos();
        emit(TodoLoaded(todos));
      } catch (e) {
        emit(TodoError(e.toString()));
      }
    });

    // Add Todo
    on<AddTodoEvent>((event, emit) async {
      try {
        await todoRepository.createTodo(event.todo);
        add(FetchTodosEvent()); // Refresh the todo list
      } catch (e) {
        emit(TodoError(e.toString()));
      }
    });

    // Update Todo
    on<UpdateTodoEvent>((event, emit) async {
      try {
        await todoRepository.updateTodo(event.todo);
        add(FetchTodosEvent()); // Refresh the todo list
      } catch (e) {
        emit(TodoError(e.toString()));
      }
    });

    // Delete Todo
    on<DeleteTodoEvent>((event, emit) async {
      try {
        await todoRepository.deleteTodoById(event.id);
        add(FetchTodosEvent()); // Refresh the todo list
      } catch (e) {
        emit(TodoError(e.toString()));
      }
    });
  }
}
