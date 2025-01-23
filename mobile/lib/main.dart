import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:todo_mobile/bloc/counter_cubit.dart';
import 'package:todo_mobile/presentation/bloc/todo_cubit.dart';
// import 'package:todo_mobile/screens/home_page.dart';
// import 'package:todo_mobile/screens/counter_page.dart';
import 'package:todo_mobile/presentation/pages/todos_page.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => TodoCubit(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodosPage(),
      // CounterPage(),
      // HomePage(),
    );
  }
}
