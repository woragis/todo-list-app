import 'package:flutter/material.dart';
import 'package:todo_mobile/presentation/pages/create_todo_page.dart';
import 'package:todo_mobile/presentation/pages/login_page.dart';
import 'package:todo_mobile/presentation/pages/profile_page.dart';
import 'package:todo_mobile/presentation/pages/register_page.dart';
import 'package:todo_mobile/presentation/pages/todos_page.dart';

class NavigatorWidget extends StatelessWidget {
  const NavigatorWidget({
    super.key,
    required GlobalKey<NavigatorState> navigatorKey,
  }) : _navigatorKey = navigatorKey;

  final GlobalKey<NavigatorState> _navigatorKey;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        Widget page = TodosPage();
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
        }
        return MaterialPageRoute(
          builder: (_) => page,
          settings: settings,
        );
      },
    );
  }
}
