class Todo {
  String id;
  String title;
  String description;
  bool completed;
  String authorId;
  String createdAt;
  String updatedAt;

  Todo({
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

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        authorId: json['author_id'],
        completed: (json['completed'] as int) == 1,
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'author_id': authorId,
        'completed': completed ? 1 : 0,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}

class NewTodo {
  String title;
  String description;
  bool completed;
  String authorId;

  NewTodo({
    required this.title,
    required this.description,
    this.completed = false,
    required this.authorId,
  });

  factory NewTodo.fromJson(Map<String, dynamic> json) => NewTodo(
        title: json['title'],
        description: json['description'],
        completed: (json['completed'] as int) == 1,
        authorId: json['author_id'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'completed': completed ? 1 : 0,
        'author_id': authorId,
      };
}
