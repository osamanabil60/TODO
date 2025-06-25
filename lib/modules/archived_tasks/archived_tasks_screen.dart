// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../shared/componants/components.dart';
// import '../../shared/cubit/cubit.dart';
// import '../../shared/cubit/states.dart';
//
// class ArchiveTasksScreen extends StatefulWidget
// {
//   @override
//   _ArchiveTasksScreen createState() => _ArchiveTasksScreen();
// }
//
//
// class _ArchiveTasksScreen extends State<ArchiveTasksScreen> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AppCubit, AppStates>
//       (
//       listener: (context, state){},
//       builder: (context, state){
//         var tasks = AppCubit.get(context).newTasks;
//         return ListView.separated(
//             itemBuilder: (context, index) => buildTaskItem(AppCubit.get(context).tasks[index], context),
//             separatorBuilder: (context, index) =>Padding(
//               padding: const EdgeInsetsDirectional.only(start:15.0,),
//               child: Container(
//                 width: double.infinity,
//                 height: 1.0,
//                 color: Colors.grey[300],
//               ),
//             ),
//             itemCount: AppCubit.get(context).tasks.length
//         ) ;
//       },
//     );
//   }
// }











import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/shared/cubit/cubit.dart';
import 'package:todo/shared/cubit/states.dart';

import '../../shared/componants/components.dart';

class ArchiveTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final tasks = AppCubit.get(context).archiveTasks;
        return ListView.separated(
          itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsetsDirectional.only(start: 15.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          itemCount: tasks.length,
        );
      },
    );
  }
}