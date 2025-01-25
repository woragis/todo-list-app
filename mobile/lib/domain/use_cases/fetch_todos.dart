import 'package:todo_mobile/data/providers/todo_api_provider.dart';
import 'package:todo_mobile/data/providers/todo_db_provider.dart';
import 'package:todo_mobile/domain/entities/todo_entity.dart';
import 'package:todo_mobile/data/mappers/todo_mapper.dart';

class FetchTodos {
  final TodoApiProvider apiProvider;
  final TodoDbProvider dbProvider;

  FetchTodos({required this.apiProvider, required this.dbProvider});

  Future<List<TodoEntity>> call() async {
    final models = await apiProvider.fetchTodos(); // Fetch from API
    return models.map((model) => TodoMapper.toEntity(model)).toList();
  }
}
