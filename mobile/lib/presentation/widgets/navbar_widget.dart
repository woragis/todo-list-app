import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class NavbarWidget extends StatefulWidget {
  const NavbarWidget({super.key});

  @override
  createState() => _NavbarWidgetState();
}

class _NavbarWidgetState extends State<NavbarWidget> {
  int _currentIndex = 0;
  List<Widget> body = const [
    Icon(Icons.home),
    Icon(Icons.menu),
    Icon(Icons.person),
  ];

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

  @override
  Widget build(BuildContext context) {
    var curvedNavigationBar = CurvedNavigationBar(
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
    );
    return Scaffold(
      body: Center(
        child: body[_currentIndex],
      ),
      backgroundColor: Colors.deepPurple,
      bottomNavigationBar: curvedNavigationBar,
    );
  }
}
