import 'package:flutter/material.dart';

class NewTasksScreen extends StatefulWidget
{
  @override
  _NewTasksScreen createState() => _NewTasksScreen();
}


class _NewTasksScreen extends State<NewTasksScreen> {


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: Center(
        child: Text(
          'New Tasks',
          style: TextStyle(
            fontSize: 20,
    ),
    ),
    ),
    );
  }
}