import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:todo_mobile/data/providers/todo_api_provider.dart';
import 'package:todo_mobile/data/providers/todo_db_provider.dart';
import 'package:todo_mobile/data/providers/user_api_provider.dart';
import 'package:todo_mobile/data/providers/user_db_provider.dart';
import 'package:todo_mobile/data/repositories/todo_repository_impl.dart';
import 'package:todo_mobile/data/repositories/user_repository_impl.dart';
import 'package:todo_mobile/domain/repositories/todo_repository.dart';
import 'package:todo_mobile/domain/repositories/user_repository.dart';
import 'package:todo_mobile/presentation/bloc/todo_bloc.dart';
import 'package:todo_mobile/presentation/bloc/user_bloc.dart';
import 'package:todo_mobile/presentation/pages/create_todo_page.dart';
import 'package:todo_mobile/presentation/pages/login_page.dart';
import 'package:todo_mobile/presentation/pages/register_page.dart';
import 'package:todo_mobile/presentation/pages/todos_page.dart';
// import 'package:todo_mobile/presentation/pages/todo_list_page.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';
// import 'package:todo_mobile/data/providers/auth_api_provider.dart';
// import 'package:todo_mobile/data/providers/auth_db_provider.dart';
// import 'package:todo_mobile/data/repositories/auth_repository.dart';
// import 'package:todo_mobile/presentation/bloc/auth_bloc.dart';
// import 'package:todo_mobile/presentation/bloc/todo_bloc.dart';
// import 'package:todo_mobile/data/providers/todo_api_provider.dart';
// import 'package:todo_mobile/data/providers/todo_db_provider.dart';
// import 'package:todo_mobile/data/repositories/todo_repository_impl.dart';
// import 'package:todo_mobile/presentation/pages/create_todo_page.dart';
// import 'package:todo_mobile/presentation/pages/register_page.dart';
// import 'package:todo_mobile/presentation/pages/todos_page.dart';

// void main() async {
//   sqfliteFfiInit();
//   databaseFactory = databaseFactoryFfi;
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final todoApiProvider = TodoApiProvider(baseUrl: "http://localhost:8080");
//     final todoDbProvider = TodoDbProvider();
//     // todoApiProvider.fetchTodos();
//     final todoRepository = TodoRepository(
//       apiProvider: todoApiProvider,
//       dbProvider: todoDbProvider,
//     );

//     final authApiProvider =
//         AuthApiProvider(baseUrl: "http://localhost:8080/auth");
//     final authDbProvider = AuthDbProvider();
//     final authRepository = AuthRepository(
//       apiProvider: authApiProvider,
//       dbProvider: authDbProvider,
//     );

//     return MultiRepositoryProvider(
//       providers: [
//         RepositoryProvider<TodoRepository>(
//           create: (context) => todoRepository,
//         ),
//         RepositoryProvider<AuthRepository>(
//           create: (context) => authRepository,
//         ),
//       ],
//       child: MultiBlocProvider(
//         providers: [
//           BlocProvider<TodoBloc>(
//             create: (context) => TodoBloc(
//               repository: RepositoryProvider.of<TodoRepository>(context),
//             )..add(FetchTodosEvent()), // Trigger fetch on app start
//           ),
//           BlocProvider<AuthBloc>(
//             create: (context) => AuthBloc(
//               repository: RepositoryProvider.of<AuthRepository>(context),
//             ),
//           ),
//         ],
//         child: MaterialApp(
//           debugShowCheckedModeBanner: false,
//           title: 'Todo App',
//           theme: ThemeData(primarySwatch: Colors.grey),
//           home: const TodosPage(),
//           routes: {
//             '/create-todo': (context) => const CreateTodoPage(),
//             '/auth/register': (context) => const RegisterPage(),
//             // '/auth/login': (context) => const LoginPage(),
//           },
//         ),
//       ),
//     );
//   }
// }

void main() async {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  final String baseUrl = 'http://127.0.0.1:8080';
  final db = await databaseFactory.openDatabase('path');
  final TodoRepository todoRepository = TodoRepositoryImpl(
    apiProvider: TodoApiProvider(baseUrl: baseUrl),
    dbProvider: TodoDbProvider(db: db),
  );
  final UserRepository userRepository = UserRepositoryImpl(
      apiProvider: UserApiProvider(baseUrl: '$baseUrl/auth'),
      dbProvider: UserDbProvider(db: db, tableName: 'users'));

  runApp(MyApp(
    todoRepository: todoRepository,
    userRepository: userRepository,
  ));
}

class MyApp extends StatelessWidget {
  final TodoRepository todoRepository;
  final UserRepository userRepository;

  const MyApp({
    super.key,
    required this.todoRepository,
    required this.userRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodoBloc(todoRepository),
        ),
        BlocProvider(
          create: (context) => UserBloc(userRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Todo App',
        initialRoute: '/',
        routes: {
          '/': (context) => TodosPage(),
          '/auth/login': (context) => LoginPage(),
          '/auth/register': (context) => RegisterPage(),
          '/create-todo': (context) => CreateTodoPage(),
        },
      ),
    );
  }
}
