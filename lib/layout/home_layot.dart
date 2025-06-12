import 'package:flutter/material.dart';
import 'package:todo/modules/new_tasks/new_tasks_screen.dart';
import 'package:todo/modules/done_tasks/done_tasks_screen.dart';
import 'package:todo/modules/archived_tasks/archived_tasks_screen.dart';


class HomeLayout extends StatefulWidget
{
  @override
  _HomeLayout createState() => _HomeLayout();
}
class _HomeLayout extends State<HomeLayout>
{
  int currentIndex = 0;
  List<Widget> screens =
      [
        NewTasksScreen(),
        DoneTasksScreen(),
        ArchiveTasksScreen(),
      ];

  List<String> titles =
      [
      'New Tasks',
      'Done Tasks',
      'Archived Tasks',
    ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[currentIndex],),
        centerTitle: true,
        ),
       body:screens[currentIndex],
       floatingActionButton: FloatingActionButton(
         onPressed: () {},
         child: Icon(
           Icons.add,
         ),

           ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index)
          {
            setState(() {
              currentIndex = index;
            });
            print(index);
          },
          showUnselectedLabels: false,
          showSelectedLabels: true,
          items:
          [
            BottomNavigationBarItem(
                icon: Icon
                  (
                  Icons.menu,

                  ),
                label: 'Tasks',
            ),
            BottomNavigationBarItem(
              icon: Icon
                (
                Icons.check_circle_outline,
              ),
              label: 'Done',
            ),
            BottomNavigationBarItem(
              icon: Icon
                (
                Icons.archive_outlined,
              ),
              label: 'Archived',
            ),

          ]
      ),
    );
  }
}