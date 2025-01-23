import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_mobile/data/models/todo_model.dart';

class TodoCubit extends Cubit<List<Todo>> {
  TodoCubit() : super([]);

  // Initialize todos
  // For testing only
  // Because of the lack of local database and lack of api connection currently
  void initializeTodos(List<Todo> todos) {
    emit(todos);
  }

  // Add a new note
  void addNote(String id, String title, String description) {
    final newTodo = Todo(id: id, title: title, description: description);
    emit([...state, newTodo]); // Add new Todo to the list
  }

  // Toggle completion status of a Todo
  void toggleCompleted(String id) {
    final updatedTodos = state.map((todo) {
      if (todo.id == id) {
        todo.toggleCompleted(); // Toggle completion for matching note
        return todo;
      }
      return todo; // Leave other Todos unchanged
    }).toList();

    emit(updatedTodos); // Emit updated state
  }

  // Delete a note (Todo)
  void deleteNote(String id) {
    final updatedTodos = state.where((todo) => todo.id != id).toList();
    emit(updatedTodos); // Emit new state without the deleted Todo
  }
}
