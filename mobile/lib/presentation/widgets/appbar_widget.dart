import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onIconPressed;

  const AppBarWidget({
    Key? key,
    required this.title,
    required this.icon,
    this.onIconPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          IconButton(
            icon: Icon(icon),
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, '/auth/register');
            },
          ),
        ],
      ),
    );
  }
}
