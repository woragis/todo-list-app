import 'package:todo_mobile/domain/entities/todo_entity.dart';

abstract class TodoRepository {
  Future<List<TodoEntity>> fetchTodos();
  Future<TodoEntity> fetchTodoById(String id);
  Future<TodoEntity> createTodo(NewTodoEntity todo);
  Future<void> deleteTodoById(String id);
  Future<void> updateTodo(TodoEntity todo);
}
