import 'package:flutter/material.dart';

class DoneTasksScreen extends StatefulWidget
{
  @override
  _DoneTasksScreen createState() => _DoneTasksScreen();
}


class _DoneTasksScreen extends State<DoneTasksScreen> {


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: Center(
        child: Text(
          'Done Tasks',
          style: TextStyle(
            fontSize: 20,
    ),
    ),
    ),
    );
  }
}