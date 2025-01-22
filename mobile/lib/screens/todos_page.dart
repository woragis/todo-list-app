import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_mobile/bloc/todo_cubit.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todos"),
      ),
      body: BlocBuilder<TodoCubit, List<Todo>>(
        builder: (context, todos) {
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return ListTile(
                title: Text(todo.title),
                trailing: Icon(
                  todo.completed
                      ? Icons.check_box
                      : Icons.check_box_outline_blank,
                  color: todo.completed ? Colors.green[700] : Colors.grey,
                ),
                onTap: () {
                  context.read<TodoCubit>().toggleCompleted(todo.title);
                },
              );
            },
          );
        },
      ),
    );
  }
}
