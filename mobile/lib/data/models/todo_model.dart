class Todo {
  String id;
  String title;
  String description;
  bool completed;
  String createdAt;
  String updatedAt;

  Todo({
    required this.id,
    required this.title,
    required this.description,
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
        completed: (json['completed'] as int) == 1,
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'completed': completed ? 1 : 0,
      };
}

class NewTodo {
  String title;
  String description;
  bool completed;

  NewTodo({
    required this.title,
    required this.description,
    this.completed = false,
  });

  factory NewTodo.fromJson(Map<String, dynamic> json) => NewTodo(
        title: json['title'],
        description: json['description'],
        completed: (json['completed'] as int) == 1,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'completed': completed ? 1 : 0,
      };
}
