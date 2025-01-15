class Todo {
  final int id;
  final String name;
  final int authorId = 1;
  bool completed;

  Todo({
    required this.id,
    required this.name,
    required this.completed,
  });

  // Factory method to create a Todo from a JSON map
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as int,
      name: json['name'] as String,
      completed: json['completed'] as bool,
    );
  }

  void toggleCompleted() {
    completed = !completed;
  }

  // Method to convert a Todo object to JSON (useful for POST/PUT requests)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'author_id': authorId,
      'completed': completed,
    };
  }
}
