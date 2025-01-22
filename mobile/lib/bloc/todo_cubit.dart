import 'package:flutter_bloc/flutter_bloc.dart';

class Todo {
  String title;
  String description;
  bool completed;

  Todo({
    required this.title,
    required this.description,
    this.completed = false,
  });

  // Toggle the completion status
  Todo toggleCompleted() {
    return Todo(
      title: title,
      description: description,
      completed: !completed,
    );
  }
}

class TodoCubit extends Cubit<List<Todo>> {
  TodoCubit() : super([]);

  // Add a new note
  void addNote(String title, String description) {
    final newTodo = Todo(title: title, description: description);
    emit([...state, newTodo]); // Add new Todo to the list
  }

  // Toggle completion status of a Todo
  void toggleCompleted(String note) {
    final updatedTodos = state.map((todo) {
      if (todo.title == note) {
        return todo.toggleCompleted(); // Toggle completion for matching note
      }
      return todo; // Leave other Todos unchanged
    }).toList();

    emit(updatedTodos); // Emit updated state
  }

  // Delete a note (Todo)
  void deleteNote(String note) {
    final updatedTodos = state.where((todo) => todo.title != note).toList();
    emit(updatedTodos); // Emit new state without the deleted Todo
  }
}
