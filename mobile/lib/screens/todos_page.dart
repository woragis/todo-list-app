import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_mobile/bloc/todo_cubit.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Todo> staticTodos = [
      Todo(
          id: "1",
          title: "Watch CS50",
          description: "Watch CS50 because of my dream online american job"),
      Todo(
          id: "2",
          title: "Finish Docker udemy course",
          description: "This is to improve my curriculum"),
      Todo(
          id: "3",
          title: "Finish Backend Fundamentals udemy course",
          description: "To improve my curriculum"),
      Todo(
          id: "4",
          title: "Finish Database Fundamentals udemy course",
          description: "Watch CS50 because of my dream online american job"),
      Todo(
          id: "5",
          title: "Finish Piano Intermediario Course",
          description: "Watch CS50 because of my dream online american job"),
      Todo(
          id: "6",
          title: "Study AWS and get the certification",
          description: "Watch CS50 because of my dream online american job"),
      Todo(
          id: "7",
          title: "Buy 1 course of acoustic guitar",
          description: "Watch CS50 because of my dream online american job"),
      Todo(
          id: "8",
          title: "Buy the course of Piano advanced by Luciano Alves",
          description: "Watch CS50 because of my dream online american job"),
      Todo(
          id: "9",
          title: "Buy the course of Piano exercises by Luciano Alves",
          description: "Watch CS50 because of my dream online american job"),
    ];

    context.read<TodoCubit>().initializeTodos(staticTodos);

    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Todos",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Icon(
                Icons.person,
                color: Colors.white,
              ),
            ],
          ),
        ),
        backgroundColor: Colors.grey[850],
        elevation: 0,
      ),
      backgroundColor: Colors.grey[900],
      body: BlocBuilder<TodoCubit, List<Todo>>(
        builder: (context, todos) {
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return ListTile(
                title: Container(
                  padding: EdgeInsets.all(0),
                  margin: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        todo.title,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        todo.description,
                        style: TextStyle(
                          color: Colors.white60,
                        ),
                      )
                    ],
                  ),
                ),
                trailing: Icon(
                  todo.completed
                      ? Icons.check_box
                      : Icons.check_box_outline_blank,
                  color: todo.completed ? Colors.green[300] : Colors.grey,
                ),
                onTap: () {
                  context.read<TodoCubit>().toggleCompleted(todo.id);
                },
              );
            },
          );
        },
      ),
    );
  }
}
