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
import 'package:todo_mobile/presentation/pages/profile_page.dart';
import 'package:todo_mobile/presentation/pages/todos_page.dart';
import 'package:todo_mobile/presentation/widgets/navigator_widget.dart';

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
        home: Main(),
      ),
    );
  }
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  createState() => _MainState();
}

class _MainState extends State<Main> {
  int _currentIndex = 0;

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    Color widgetColor = Colors.white;
    List<Map<String, Object>> pageProperties = [
      {
        'key': 'home',
        'name': 'Home',
        'page': TodosPage(),
        'widget': Icon(
          Icons.home,
          color: widgetColor,
        ),
      },
      {
        'key': 'create-todo',
        'name': 'Create New Todo',
        'page': CreateTodoPage(),
        'widget': Icon(
          Icons.add,
          color: widgetColor,
        ),
      },
      {
        'key': 'profie',
        'name': 'Profile',
        'page': ProfilePage(),
        'widget': Icon(
          Icons.person,
          color: widgetColor,
        ),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                pageProperties[_currentIndex]['name'] as String,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.grey,
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
      body: NavigatorWidget(
          navigatorKey: _navigatorKey,
          pagesData: pageProperties,
          pageIndex: _currentIndex),
    );
  }
}
