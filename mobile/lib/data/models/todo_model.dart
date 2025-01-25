class TodoModel {
  String id;
  String title;
  String description;
  bool completed;
  String authorId;
  DateTime createdAt;
  DateTime updatedAt;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.authorId,
    this.completed = false,
    required this.createdAt,
    required this.updatedAt,
  });

  void toggleCompleted() {
    completed = !completed;
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        authorId: json['author_id'],
        completed: (json['completed'] as int) == 1,
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'author_id': authorId,
        'completed': completed ? 1 : 0,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };
}

class NewTodoModel {
  String title;
  String description;
  bool completed;
  String authorId;

  NewTodoModel({
    required this.title,
    required this.description,
    this.completed = false,
    required this.authorId,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'completed': completed ? 1 : 0,
        'author_id': authorId,
      };
}
