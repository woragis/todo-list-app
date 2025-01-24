import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_mobile/data/models/todo_model.dart';
import 'package:todo_mobile/presentation/bloc/auth_bloc.dart';
import 'package:todo_mobile/presentation/bloc/todo_bloc.dart';

class CreateTodoPage extends StatefulWidget {
  const CreateTodoPage({super.key});

  @override
  State<CreateTodoPage> createState() => _CreateTodoPageState();
}

class _CreateTodoPageState extends State<CreateTodoPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm(BuildContext context) {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (title.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticatedState) {
      final authorId = authState.user.id;

      // Dispatch an event to create a new todo
      context.read<TodoBloc>().add(
            AddTodoEvent(
              newTodo: NewTodo(
                title: title,
                description: description,
                authorId: authorId,
              ),
            ),
          );

      // Navigate back after creating the todo
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You must be logged in'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Todo',
            style: TextStyle(
              color: Colors.white,
            )),
        backgroundColor: Colors.grey.shade300,
      ),
      backgroundColor: Colors.green.shade300,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => _submitForm(context),
              child: const Text('Create Todo'),
            ),
          ],
        ),
      ),
    );
  }
}
