class TodoEntity {
  final String id;
  final String title;
  final String description;
  final bool completed;
  final String authorId;
  final DateTime createdAt;
  final DateTime updatedAt;

  TodoEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.completed,
    required this.authorId,
    required this.createdAt,
    required this.updatedAt,
  });
}

class NewTodoEntity {
  final String title;
  final String description;
  final String authorId;

  NewTodoEntity({
    required this.title,
    required this.description,
    required this.authorId,
  });
}
