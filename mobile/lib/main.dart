import 'package:curved_navigation_bar/curved_navigation_bar.dart';
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
import 'package:todo_mobile/presentation/pages/profile_page.dart';
import 'package:todo_mobile/presentation/pages/register_page.dart';
import 'package:todo_mobile/presentation/pages/todos_page.dart';
import 'package:todo_mobile/presentation/widgets/appbar_widget.dart';
import 'package:todo_mobile/presentation/widgets/navbar_widget.dart';
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

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  int _currentIndex = 0;

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  final List<String> _routes = [
    '/',
    '/create-todo',
    '/auth/register',
    '/auth/login',
    '/profile',
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> pageProperties = const [
      {
        'key': 'home',
        'name': 'Home',
        'widget': Icon(Icons.home),
      },
      {
        'key': 'create-todo',
        'name': 'Create New Todo',
        'widget': Icon(Icons.add),
      },
      {
        'key': 'profie',
        'name': 'Profile',
        'widget': Icon(Icons.person),
      },
      // {
      //   'key': 'settings',
      //   'name': 'Settings',
      //   'widget': Icon(Icons.settings),
      // },
    ];
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Title',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              IconButton(
                icon: Icon(Icons.abc),
                color: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, '/auth/register');
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.deepPurple,
        color: Colors.white,
        animationDuration: Duration(milliseconds: 300),
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: pageProperties.map((page) {
          return page['widget'] as Widget;
        }).toList(),
      ),
      // bottomNavigationBar: NavbarWidget(),
      body: Navigator(
        key: _navigatorKey,
        onGenerateRoute: (RouteSettings settings) {
          Widget page;
          switch (settings.name) {
            case '/':
              page = const TodosPage();
              break;
            case 'create-todo':
              page = const CreateTodoPage();
              break;
            case 'auth/register':
              page = const RegisterPage();
              break;
            case 'auth/login':
              page = const LoginPage();
              break;
            case 'profile':
              page = const ProfilePage();
              break;
            default:
              page = const TodosPage();
              break;
          }
          return MaterialPageRoute(
            builder: (_) => page,
            settings: settings,
          );
        },
      ),
    );
  }

  String getAppBarTitle() {
    switch (_currentIndex) {
      case 0:
        return 'Todo List';
      case 1:
        return 'Create Todo';
      case 2:
        return 'Register';
      case 3:
        return 'Login';
      case 4:
        return 'Profile';
      default:
        return '';
    }
  }
}
