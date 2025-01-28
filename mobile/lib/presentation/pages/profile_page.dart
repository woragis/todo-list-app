import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_mobile/presentation/bloc/user_bloc.dart';
import 'package:todo_mobile/presentation/bloc/user_state.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoadedState) {
          final user = state.user;
          final token = state.token;
          return Column(
            children: [
              Text("Id: " + user.id),
              Text("Name: " + user.name),
              Text("Email: " + user.email),
              Text("Password: " + user.password),
              Text("Token: " + token),
            ],
          );
        } else {
          return Center(
            child: Text("Login"),
          );
        }
      },
    );
  }
}
