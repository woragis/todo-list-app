import 'package:todo_mobile/data/providers/todo_api_provider.dart';
import 'package:todo_mobile/domain/entities/todo_entity.dart';
import 'package:todo_mobile/data/mappers/todo_mapper.dart';

class CreateTodo {
  final TodoApiProvider apiProvider;

  CreateTodo({required this.apiProvider});

  Future<TodoEntity> call(NewTodoEntity todo) async {
    final model = NewTodoMapper.toModel(todo);
    final createdModel = await apiProvider.createTodo(model);
    return TodoMapper.toEntity(createdModel);
  }
}
