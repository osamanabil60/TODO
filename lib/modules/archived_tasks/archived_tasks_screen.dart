import 'package:flutter/material.dart';

class ArchiveTasksScreen extends StatefulWidget
{
  @override
  _ArchiveTasksScreen createState() => _ArchiveTasksScreen();
}


class _ArchiveTasksScreen extends State<ArchiveTasksScreen> {


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: Center(
        child: Text(
          'Archive Tasks',
          style: TextStyle(
            fontSize: 20,
    ),
    ),
    ),
    );
  }
}