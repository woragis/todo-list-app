import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_mobile/presentation/bloc/auth_bloc.dart';
import 'package:todo_mobile/presentation/widgets/appbar_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarWidget(title: "Profile", icon: Icons.person),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        if (state is AuthAuthenticatedState) {
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
      }),
    );
  }
}
