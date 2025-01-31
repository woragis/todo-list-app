import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';
import 'package:todo_mobile/domain/entities/todo_entity.dart';
import 'package:todo_mobile/presentation/bloc/todo_bloc.dart';
import 'package:todo_mobile/presentation/bloc/todo_event.dart';
import 'package:todo_mobile/presentation/bloc/user_bloc.dart';
import 'package:todo_mobile/presentation/bloc/user_state.dart';

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

    final userState = context.read<UserBloc>().state;
    if (userState is UserLoadedState) {
      final authorId = userState.user.id;

      // Dispatch an event to create a new todo
      context.read<TodoBloc>().add(
            TodoCreateEvent(
              NewTodoEntity(
                title: title,
                description: description,
                authorId: authorId,
              ),
            ),
          );

      // Navigate back after creating the todo
      Navigator.of(context).pop();
    } else {
      toastification.show(
        context: context,
        type: ToastificationType.error,
        style: ToastificationStyle.fillColored,
        title: Text("Can't create todo"),
        description: Text("You need to be logged in"),
        alignment: Alignment.bottomRight,
        autoCloseDuration: const Duration(seconds: 4),
        borderRadius: BorderRadius.circular(12.0),
        dragToClose: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
