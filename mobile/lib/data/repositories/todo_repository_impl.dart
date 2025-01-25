import 'package:todo_mobile/data/providers/todo_api_provider.dart';
import 'package:todo_mobile/data/providers/todo_db_provider.dart';
import 'package:todo_mobile/data/mappers/todo_mapper.dart';
import 'package:todo_mobile/domain/entities/todo_entity.dart';
import 'package:todo_mobile/domain/repositories/todo_repository.dart';

// class TodoRepository {
//   final TodoApiProvider apiProvider;
//   final TodoDbProvider dbProvider;

//   TodoRepository({
//     required this.apiProvider,
//     required this.dbProvider,
//   });

//   Future<List<TodoModel>> getTodos({bool fromLocal = false}) async {
//     try {
//       print("Fetching api");
//       final todos = await apiProvider.fetchTodos();
//       await dbProvider.saveTodos(todos);
//       return todos;
//     } catch (e) {
//       return await dbProvider.getTodos();
//     }
//   }

//   Future<TodoModel> getTodoById(String id, {bool fromLocal = true}) async {
//     if (fromLocal) {
//       return await dbProvider.getTodoById(id);
//     } else {
//       final todo = await apiProvider.fetchTodoById(id);
//       await dbProvider.createTodo(todo); // Sync local database
//       return todo;
//     }
//   }

//   Future<TodoModel> createTodo(NewTodoModel todo) async {
//     TodoModel createdTodo = await apiProvider.createTodo(todo);
//     await dbProvider.createTodo(createdTodo);
//     return createdTodo;
//   }

//   Future<void> updateTodo(TodoModel todo) async {
//     await dbProvider.updateTodo(todo);
//     await apiProvider.updateTodo(todo);
//   }

//   Future<void> deleteTodoById(String id) async {
//     await dbProvider.deleteTodoById(id);
//     await apiProvider.deleteTodoById(id);
//   }
// }

class TodoRepositoryImpl implements TodoRepository {
  final TodoApiProvider apiProvider;
  final TodoDbProvider dbProvider;

  TodoRepositoryImpl({
    required this.apiProvider,
    required this.dbProvider,
  });

  @override
  Future<List<TodoEntity>> fetchTodos() async {
    // Fetch todos from the API
    final models = await apiProvider.fetchTodos();
    // Map models to entities
    return models.map((model) => TodoMapper.toEntity(model)).toList();
  }

  @override
  Future<TodoEntity> fetchTodoById(String id) async {
    final model = await apiProvider.fetchTodoById(id);
    return TodoMapper.toEntity(model);
  }

  @override
  Future<TodoEntity> createTodo(NewTodoEntity todo) async {
    final model = NewTodoMapper.toModel(todo);
    final createdModel = await apiProvider.createTodo(model);
    return TodoMapper.toEntity(createdModel);
  }

  @override
  Future<void> deleteTodoById(String id) async {
    await apiProvider.deleteTodoById(id);
  }

  @override
  Future<void> updateTodo(TodoEntity todo) async {
    final model = TodoMapper.toModel(todo);
    await apiProvider.updateTodo(model);
  }
}
