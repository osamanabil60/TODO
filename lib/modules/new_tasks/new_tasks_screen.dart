import 'package:flutter/material.dart';
import 'package:todo/shared/componants/components.dart';

import '../../shared/componants/constants.dart';

class NewTasksScreen extends StatefulWidget
{
  @override
  _NewTasksScreen createState() => _NewTasksScreen();
}


class _NewTasksScreen extends State<NewTasksScreen> {

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => buildTaskItem(tasks[index]),
        separatorBuilder: (context, index) =>Padding(
          padding: const EdgeInsetsDirectional.only(start:15.0,),
          child: Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[300],
          ),
        ),
        itemCount: tasks.length) ;
  }
}