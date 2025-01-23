import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_mobile/data/models/todo_model.dart';
import 'package:todo_mobile/presentation/bloc/todo_bloc.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TodoLoaded) {
            final todos = state.todos;
            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final Todo todo = todos[index];
                return ListTile(
                  title: Text(todo.title),
                  subtitle: Text(todo.description),
                  trailing: Icon(
                    todo.completed
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                    color: todo.completed ? Colors.green[700] : Colors.grey,
                  ),
                  onTap: () {
                    // Trigger toggle event
                    context
                        .read<TodoBloc>()
                        .add(ToggleTodoCompletionEvent(todo.id));
                  },
                );
              },
            );
          } else if (state is TodoError) {
            return Center(
              child: Text('Error: ${state.message}'),
            );
          }
          return const Center(child: Text('No Todos Found.'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Open a form to add a new todo
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
