import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:todo/modules/done_tasks/done_tasks_screen.dart';
import 'package:todo/modules/new_tasks/new_tasks_screen.dart';
import 'package:todo/shared/cubit/cubit.dart';
import 'package:todo/shared/cubit/states.dart';

import '../shared/componants/components.dart';

class MyTheme with ChangeNotifier {
  static bool isDark = true;

  ThemeMode currentTheme() {
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void switchTheme() {
    isDark = !isDark;
    notifyListeners();
  }
}

class HomeLayout extends StatefulWidget {
  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _timeController = TextEditingController();
  final _dateController = TextEditingController();
  final MyTheme _currentTheme = MyTheme();

  @override
  void initState() {
    super.initState();
    _currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _currentTheme.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _currentTheme.currentTheme(),
      home: BlocProvider(
        create: (BuildContext context) => AppCubit()..createDatabase(),
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {
            if (state is AppInsertDatabaseState) {
              _clearFormFields();
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            final cubit = AppCubit.get(context);
            return Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                title: Text(cubit.titles[cubit.currentIndex]),
                centerTitle: true,
                actions: [
                  IconButton(
                    icon: Icon(MyTheme.isDark
                        ? Icons.wb_sunny
                        : Icons.brightness_2),
                    onPressed: () {
                      _currentTheme.switchTheme();
                    },
                  ),
                ],
              ),
              body: _buildBody(cubit, state),
              floatingActionButton: Container(
                child:
                  FloatingActionButton(
                    heroTag: 'task_fab',
                    child: Icon(cubit.fabIcon),
                    onPressed: () => _handleFloatingActionButtonPress(cubit, context),
                  ),

              ),
              bottomNavigationBar: _buildBottomNavigationBar(cubit),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody(AppCubit cubit, AppStates state) {
    if (state is AppDatabaseLoadingState) {
      return const Center(child: CircularProgressIndicator());
    }
    return cubit.screens[cubit.currentIndex];
  }

  void _handleFloatingActionButtonPress(AppCubit cubit, BuildContext context) {
    if (cubit.isBottomSheetShown) {
      _submitTaskForm(cubit);
    } else {
      _showTaskFormBottomSheet(cubit, context);
    }
  }

  void _submitTaskForm(AppCubit cubit) {
    if (_formKey.currentState!.validate()) {
      cubit.insertToDatabase(
        title: _titleController.text,
        date: _dateController.text,
        time: _timeController.text,
      );
    }
  }

  void _showTaskFormBottomSheet(AppCubit cubit, BuildContext context) {
    _scaffoldKey.currentState?.showBottomSheet(
          (context) => Container(
        color: Theme.of(context).cardColor,
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTitleField(),
              const SizedBox(height: 15.0),
              _buildTimeField(context),
              const SizedBox(height: 15.0),
              _buildDateField(context),
            ],
          ),
        ),
      ),
      elevation: 20.0,
    ).closed.then((_) {
      cubit.changeBottomSheetState(isShown: false, icon: Icons.edit);
    });

    cubit.changeBottomSheetState(isShown: true, icon: Icons.add);
  }

  Widget _buildTitleField() {
    return defaultFormField(
      controller: _titleController,
      type: TextInputType.text,
      validate: (value) => value?.isEmpty ?? true ? 'Title must not be empty' : null,
      label: 'Task Title',
      prefix: Icons.title,
    );
  }

  Widget _buildTimeField(BuildContext context) {
    return defaultFormField(
      controller: _timeController,
      type: TextInputType.datetime,
      onTap: () => _selectTime(context),
      validate: (value) => value?.isEmpty ?? true ? 'Time must not be empty' : null,
      label: 'Task Time',
      prefix: Icons.watch_later_outlined,
    );
  }

  Widget _buildDateField(BuildContext context) {
    return defaultFormField(
      controller: _dateController,
      type: TextInputType.datetime,
      onTap: () => _selectDate(context),
      validate: (value) => value?.isEmpty ?? true ? 'Date must not be empty' : null,
      label: 'Task Date',
      prefix: Icons.calendar_today,
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      _timeController.text = time.format(context);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      _dateController.text = DateFormat.yMMMd().format(date);
    }
  }

  Widget _buildBottomNavigationBar(AppCubit cubit) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: cubit.currentIndex,
      onTap: cubit.changeIndex,
      showUnselectedLabels: false,
      showSelectedLabels: true,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.menu),
          label: 'Tasks',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.check_circle_outline),
          label: 'Done',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.archive_outlined),
          label: 'Archived',
        ),
      ],
    );
  }

  void _clearFormFields() {
    _titleController.clear();
    _timeController.clear();
    _dateController.clear();
  }
}


//------------------------------------------------------------------------------
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:todo/modules/new_tasks/new_tasks_screen.dart';
// import 'package:todo/modules/done_tasks/done_tasks_screen.dart';
// import 'package:todo/modules/archived_tasks/archived_tasks_screen.dart';
// import 'package:todo/shared/componants/components.dart';
// import 'package:sqflite/sqflite.dart';
//
// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../shared/componants/constants.dart';
// import '../shared/cubit/cubit.dart';
// import '../shared/cubit/states.dart';
// import '../shared/blocobserver.dart';
//
//
//
// class HomeLayout extends StatelessWidget
// {
//   var scaffoldKey = GlobalKey<ScaffoldState>();
//   late Database database;
//   var formKey = GlobalKey<FormState>();
//
//   var titleController = TextEditingController();
//   var timeController = TextEditingController();
//   var dateController = TextEditingController();
//   var title = 'title';
//   var time = 'time';
//   var date = 'date';
//
//
//
//
//
//   @override
//   // void initState() {
//   //   // TODO: implement initState
//   //   super.initState();
//   //
//   //   createDatabase();
//   //   //getDataFromDatabase(database);
//   // }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (BuildContext context) => AppCubit()..createDatabase(),
//
//       child: BlocConsumer<AppCubit, AppStates>(
//           listener:(context, state) {
//             if (state is AppInsertDatabaseState)
//             {
//               Navigator.pop(context);
//             }
//           } ,
//           builder: (context, state) {
//             AppCubit cubit = AppCubit.get(context);
//
//           return Scaffold(
//           key: scaffoldKey,
//           appBar: AppBar(
//             title: Text(cubit.titles[cubit.currentIndex],),
//             centerTitle: true,
//           ),
//           body:ConditionalBuilder(
//             condition: true ,
//             builder:(context) => cubit.screens[cubit.currentIndex],
//             fallback:(context) => Center(child: CircularProgressIndicator()),
//           ),
//           //screens[currentIndex],
//           floatingActionButton: FloatingActionButton(
//               child: Icon(
//                 cubit.fabIcon,
//               ),
//               onPressed: () {
//                 if (cubit.isBottomSheetShown)
//                 {
//                   if (formKey.currentState!.validate())
//                   {
//                     cubit.insertToDatabase(
//                       title: titleController.text,
//                       date: dateController.text,
//                       time: timeController.text,
//                     ).then((value)
//                     {
//                       cubit.getDataFromDatabase(database);
//                       {
//                         Navigator.pop(context);
//
//                         // setState(() {
//                         //   isBottomSheetShown = false;
//                         //   tasks = value;
//                         //   print(tasks);
//                         //
//                         //   fabIcon = Icons.edit;
//                         //
//                         // });
//
//                       }
//                     });
//                   }
//                 } else
//                 {
//                   scaffoldKey.currentState?.showBottomSheet(
//                         (context) => Container(
//                       color: Colors.white,
//                       padding: EdgeInsets.all(
//                         20.0,
//                       ),
//                       child: Form(
//                         key: formKey,
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             defaultFormField(
//                               controller: titleController,
//                               type: TextInputType.text,
//                               validate: (String? value) {
//                                 if (value==null || value.isEmpty) {
//                                   return 'title must not be empty';
//                                 }
//
//                                 return null;
//                               },
//                               label: 'Task Title',
//                               prefix: Icons.title,
//                             ),
//                             SizedBox(
//                               height: 15.0,
//                             ),
//                             defaultFormField(
//                               controller: timeController,
//                               type: TextInputType.datetime,
//                               onTap: () {
//                                 showTimePicker(
//                                   context: context,
//                                   initialTime: TimeOfDay.now(),
//                                 ).then((value) {
//                                   timeController.text =
//                                       value!.format(context).toString();
//                                   print(value.format(context));
//                                 });
//                               },
//                               validate: (String? value) {
//                                 if (value==null || value.isEmpty) {
//                                   return 'time must not be empty';
//                                 }
//
//                                 return null;
//                               },
//                               label: 'Task Time',
//                               prefix: Icons.watch_later_outlined,
//                             ),
//                             SizedBox(
//                               height: 15.0,
//                             ),
//                             defaultFormField(
//                               controller: dateController,
//                               type: TextInputType.datetime,
//                               onTap: () {
//                                 showDatePicker(
//                                   context: context,
//                                   initialDate: DateTime.now(),
//                                   firstDate: DateTime.now(),
//                                   lastDate: DateTime.parse('2021-05-03'),
//                                 ).then((value) {
//                                   dateController.text =
//                                       DateFormat.yMMMd().format(value!);
//                                 });
//                               },
//                               validate: (String? value) {
//                                 if (value==null || value.isEmpty) {
//                                   return 'date must not be empty';
//                                 }
//
//                                 return null;
//                               },
//                               label: 'Task Date',
//                               prefix: Icons.calendar_today,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     elevation: 20.0,
//                   ).closed.then((value) {
//                     Navigator.pop(context);
//                     cubit.changeBottomSheetState(isShown: false, icon: Icons.edit);
//                     // setState(() {
//                     //   fabIcon = Icons.add;
//                     // });
//                   });
//                   cubit.changeBottomSheetState(isShown:true ,icon:  Icons.add);
//                   // setState(() {
//                   //   fabIcon = Icons.add;
//                   // });
//                   // insertToDatabase();
//                 }
//               }
//           ),
//           bottomNavigationBar: BottomNavigationBar(
//               type: BottomNavigationBarType.fixed,
//               currentIndex: AppCubit.get(context).currentIndex,
//               onTap: (index) {
//                 // setState(() {
//                 //   currentIndex = index;
//                 // });
//                 AppCubit.get(context).changeIndex(index);
//                 print(index);
//               },
//               showUnselectedLabels: false,
//               showSelectedLabels: true,
//               items:
//               [
//                 BottomNavigationBarItem(
//                   icon: Icon
//                     (
//                     Icons.menu,
//
//                   ),
//                   label: 'Tasks',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon
//                     (
//                     Icons.check_circle_outline,
//                   ),
//                   label: 'Done',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon
//                     (
//                     Icons.archive_outlined,
//                   ),
//                   label: 'Archived',
//                 ),
//
//               ]
//           ),
//         );
//           },
//       ),
//     );
//   }
//
//   //------------------------------------------------------------------------------------------
//
// //-------------------------------------------------------------------------------------------------------
// }

