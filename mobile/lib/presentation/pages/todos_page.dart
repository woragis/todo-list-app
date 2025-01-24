import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_mobile/data/models/todo_model.dart';
import 'package:todo_mobile/presentation/bloc/todo_bloc.dart';
import 'package:todo_mobile/presentation/widgets/appbar_widget.dart';
import 'package:todo_mobile/presentation/widgets/todos_widget.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: AppBarWidget(title: 'Todos', icon: Icons.person),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TodoLoadedState) {
            final todos = state.todos;

            if (todos.isEmpty) {
              return Center(
                child: Text(
                  'No Todos',
                ),
              );
            }

            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final Todo todo = todos[index];

                return TodosWidget(todo: todo);
                // return ListTile(
                //   title: Text(todo.title),
                //   subtitle: Text(todo.description),
                //   trailing: Icon(
                //     todo.completed
                //         ? Icons.check_box
                //         : Icons.check_box_outline_blank,
                //     color: todo.completed ? Colors.green[700] : Colors.grey,
                //   ),
                //   onTap: () {
                //     // Trigger toggle event
                //     context
                //         .read<TodoBloc>()
                //         .add(ToggleTodoCompletionEvent(todo.id));
                //   },
                // );
              },
            );
          } else if (state is TodoErrorState) {
            return Center(
              child: Text('Error: ${state.message}'),
            );
          }
          return const Center(child: Text('No Todos Found.'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        // Open a form to add a new todo
        onPressed: () => Navigator.of(context).pushNamed('/create-todo'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
