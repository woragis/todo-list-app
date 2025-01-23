import 'package:flutter_bloc/flutter_bloc.dart';

class Todo {
  String id;
  String title;
  String description;
  bool completed;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    this.completed = false,
  });

  // Toggle the completion status
  Todo toggleCompleted() {
    return Todo(
      id: id,
      title: title,
      description: description,
      completed: !completed,
    );
  }
}

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
        return todo.toggleCompleted(); // Toggle completion for matching note
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
