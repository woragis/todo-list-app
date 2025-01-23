import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_mobile/presentation/bloc/todo_bloc.dart'; // Your TodoBloc file
import 'package:todo_mobile/data/data_providers/todo_api_provider.dart';
import 'package:todo_mobile/data/data_providers/todo_db_provider.dart';
import 'package:todo_mobile/data/repositories/todo_repository.dart';
import 'package:todo_mobile/presentation/pages/todos_page.dart'; // Your TodosPage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final todoApiProvider = TodoApiProvider(baseUrl: "http://localhost:8080");
    final todoDbProvider = TodoDbProvider();
    final todoRepository = TodoRepository(
      apiProvider: todoApiProvider,
      dbProvider: todoDbProvider,
    );
    print("Main Page");

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<TodoRepository>(
          create: (context) => todoRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TodoBloc>(
            create: (context) => TodoBloc(
              repository: RepositoryProvider.of<TodoRepository>(context),
            )..add(FetchTodosEvent()), // Trigger fetch on app start
          ),
        ],
        child: MaterialApp(
          title: 'Todo App',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: const TodosPage(),
        ),
      ),
    );
  }
}
