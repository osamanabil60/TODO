import 'package:flutter/material.dart';
import 'package:todo/modules/new_tasks/new_tasks_screen.dart';
import 'package:todo/modules/done_tasks/done_tasks_screen.dart';
import 'package:todo/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:sqflite/sqflite.dart';



//import 'package:todo/layout/database_helper.dart';
//import 'package:sqflite_common_ffi/sqflite_ffi.dart';



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

  late Database database;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

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
       body:screens[currentIndex],
       floatingActionButton: FloatingActionButton(
         onPressed: ()
         {

           insertToDatabase();
         },
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

Future<void> insertToDatabase() async
{
  return await database.transaction((txn)
  {
    return  txn.rawInsert(
        'INSERT INTO tasks(title, date, time, status) VALUES("TAsks 1", "25/10/2023", "11", "new")'
    )
        .then((value) {
          print(' inserted successfully');
    }).catchError((error) {
      print('Error When Inserting New Record ${error.toString()}');
    });

  });

}
  //------------------------------------------------------------------------------------------------------

}