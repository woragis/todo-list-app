import 'package:todo_mobile/data/providers/todo_api_provider.dart';

class DeleteTodo {
  final TodoApiProvider apiProvider;

  DeleteTodo({required this.apiProvider});

  Future<void> call(String id) async {
    await apiProvider.deleteTodoById(id);
  }
}
