import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_mobile/presentation/bloc/todo_bloc.dart';
import 'package:todo_mobile/data/models/todo_model.dart';

class TodosWidget extends StatelessWidget {
  const TodosWidget({
    super.key,
    required this.todo,
  });

  final TodoModel todo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Container(
        padding: EdgeInsets.all(0),
        margin: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              todo.title,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              todo.description,
              style: TextStyle(
                color: Colors.white60,
              ),
            )
          ],
        ),
      ),
      trailing: Icon(
        todo.completed ? Icons.check_box : Icons.check_box_outline_blank,
        color: todo.completed ? Colors.green[300] : Colors.grey,
      ),
      onTap: () {
        context.read<TodoBloc>().add(ToggleTodoCompletionEvent(todo.id));
      },
    );
  }
}
