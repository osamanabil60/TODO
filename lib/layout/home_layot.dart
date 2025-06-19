import 'package:flutter/material.dart';
import 'package:todo/modules/new_tasks/new_tasks_screen.dart';
import 'package:todo/modules/done_tasks/done_tasks_screen.dart';
import 'package:todo/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:todo/shared/componants/components.dart';
import 'package:sqflite/sqflite.dart';


import 'package:intl/intl.dart';
//import 'package:todo/layout/database_helper.dart';
//import 'package:sqflite_common_ffi/sqflite_ffi.dart';


class HomeLayout extends StatefulWidget {
  @override
  _HomeLayout createState() => _HomeLayout();
}

class _HomeLayout extends State<HomeLayout> {
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

  late Database database;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var title = 'title';
  var time = 'time';
  var date = 'date';

  //final DatabaseHelper _dbHelper = DatabaseHelper();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    createDatabase();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(titles[currentIndex],),
        centerTitle: true,
      ),
      body: screens[currentIndex],
      floatingActionButton: FloatingActionButton(
          child: Icon(
            fabIcon,
          ),
          onPressed: () {
            if (isBottomSheetShown)
            {
              if (formKey.currentState!.validate())
              {
                insertToDatabase(
                  title: titleController.text,
                  date: dateController.text,
                  time: timeController.text,
                ).then((value)
                {
                  Navigator.pop(context);
                  isBottomSheetShown = false;
                  setState(() {
                    fabIcon = Icons.edit;
                  });
                });
              }
            } else
            {
              scaffoldKey.currentState?.showBottomSheet(
                    (context) => Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(
                    20.0,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        defaultFormField(
                          controller: titleController,
                          type: TextInputType.text,
                          validate: (String? value) {
                            if (value==null || value.isEmpty) {
                              return 'title must not be empty';
                            }

                            return null;
                          },
                          label: 'Task Title',
                          prefix: Icons.title,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: timeController,
                          type: TextInputType.datetime,
                          onTap: () {
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            ).then((value) {
                              timeController.text =
                                  value!.format(context).toString();
                              print(value.format(context));
                            });
                          },
                          validate: (String? value) {
                            if (value==null || value.isEmpty) {
                              return 'time must not be empty';
                            }

                            return null;
                          },
                          label: 'Task Time',
                          prefix: Icons.watch_later_outlined,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: dateController,
                          type: TextInputType.datetime,
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.parse('2021-05-03'),
                            ).then((value) {
                              dateController.text =
                                  DateFormat.yMMMd().format(value!);
                            });
                          },
                          validate: (String? value) {
                            if (value==null || value.isEmpty) {
                              return 'date must not be empty';
                            }

                            return null;
                          },
                          label: 'Task Date',
                          prefix: Icons.calendar_today,
                        ),
                      ],
                    ),
                  ),
                ),
                elevation: 20.0,
              );
              isBottomSheetShown = true;
              setState(() {
                fabIcon = Icons.add;
              });
              // insertToDatabase();
            }
          }
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) {
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

  //------------------------------------------------------------------------------------------

  void createDatabase() async {
    database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        // id integer
        // title String
        // date String
        // time String
        // status String

        print('database created');
        database
            .execute(
            'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error When Creating Table ${error.toString()}');
        });
      },
      onOpen: (database) {
        print('database opened');
      },
    );
  }

  // Future insertToDatabase({
  //   @required String title,
  //   @required String time,
  //   @required String date,
  // }) async {
  //   return await database.transaction((txn)
  //  {
  //    txn
  //         .rawInsert(
  //       'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$time", "$date", "new")',
  //     )
  //         .then((value) {
  //       print('$value inserted successfully');
  //     }).catchError((error) {
  //       print('Error When Inserting New Record ${error.toString()}');
  //     });

  //return null;
  //   });
  // }

  Future<void> insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async
  {
    return await database.transaction((txn) {
      return txn.rawInsert(
          'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$time", "$date", "new")'
      )
          .then((value) {
        print('$value inserted successfully');
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });
    });
  }
//------------------------------------------------------------------------------------------------------

}