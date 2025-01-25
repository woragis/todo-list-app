// Use this to change between
// domain/entities/todo.dart and data/models/todo.dart
import 'package:todo_mobile/data/models/todo_model.dart';
import 'package:todo_mobile/domain/entities/todo_entity.dart';

class TodoMapper {
  static TodoEntity toEntity(TodoModel model) => TodoEntity(
        id: model.id,
        title: model.title,
        description: model.description,
        completed: model.completed,
        authorId: model.authorId,
        createdAt: model.createdAt,
        updatedAt: model.updatedAt,
      );

  static TodoModel toModel(TodoEntity entity) => TodoModel(
        id: entity.id,
        title: entity.title,
        description: entity.description,
        completed: entity.completed,
        authorId: entity.authorId,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );
}
