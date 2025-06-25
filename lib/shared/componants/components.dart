// import 'package:bloc/bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:todo/shared/cubit/cubit.dart';
// import 'package:todo/shared/cubit/states.dart';
//
//
// Widget defaultButton({
//   double width = double.infinity,
//   Color background = Colors.blue,
//   bool isUpperCase = true,
//   double radius = 3.0,
//   required VoidCallback function,
//   required String text,
// }) => Container(
//   width: width,
//   height: 50.0,
//   decoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(radius),
//     color: background,
//   ),
//   child: MaterialButton(
//     onPressed: function,
//     child: Text(
//       isUpperCase ? text.toUpperCase() : text,
//       style: const TextStyle(color: Colors.white),
//     ),
//   ),
// );
//
// Widget defaultFormField({
//   required TextEditingController controller,
//   required TextInputType type,
//   ValueChanged<String>? onSubmit,
//   ValueChanged<String>? onChange,
//   VoidCallback? onTap,
//   bool isPassword = false,
//   required String? Function(String?) validate,
//   required String label,
//   required IconData prefix,
//   IconData? suffix,
//   VoidCallback? suffixPressed,
//   bool isClickable = true,
// }) => TextFormField(
//   controller: controller,
//   keyboardType: type,
//   obscureText: isPassword,
//   enabled: isClickable,
//   onFieldSubmitted: onSubmit,
//   onChanged: onChange,
//   onTap: onTap,
//   validator: validate,
//   decoration: InputDecoration(
//     labelText: label,
//     prefixIcon: Icon(prefix),
//     suffixIcon: suffix != null
//         ? IconButton(
//       onPressed: suffixPressed,
//       icon: Icon(suffix),
//     )
//         : null,
//     border: const OutlineInputBorder(),
//   ),
// );
// //------------------------------------------------------------------------------/
// //TextFormField defaultFormField({
//   //required TextEditingController controller,
//   //required TextInputType type,
//  // required String?Function(String?) validate,  // Changed this line
//  // required String label,
// //  required IconData prefix,
//   //void Function()? onTap,
// ///}) => TextFormField(
//   //controller: controller,
//   //keyboardType: type,
//   //validator: validate,  // Removed the parentheses
//  // onTap: onTap,
//  // decoration: InputDecoration(
// //    labelText: label,
//  //   prefixIcon: Icon(prefix),
// //    border: OutlineInputBorder(),
// //  ),
// //);
// //----------------------------------------------------------------------------------------------
// Widget buildTaskItem(Map model, context) =>Padding(
//   padding: const EdgeInsets.all(8.0),
//   child: Row(
//     children:
//     [
//       CircleAvatar(
// child: Text('${model['time']}'),
// radius:40,
// backgroundColor: Colors.blueGrey,
// ),
//       SizedBox(
// width: 20.0,
// ),
//       Expanded(
//   child: Column(
//   mainAxisSize: MainAxisSize.min,
//   crossAxisAlignment: CrossAxisAlignment.start,
//   children: [
//   Text(
//   '${model['title']}',
//   style: TextStyle(
//   fontSize: 16.0,
//   fontWeight: FontWeight.bold,
//   ),
//   ),
//   Text(
//   '${model['date']}',
//   style: TextStyle(
//   color: Colors.blueGrey,
//   ),
//   )
//
//   ],
//   ),
// ),
//       SizedBox(
//     width: 20.0,
//   ),
//       IconButton(
//       onPressed:()
//       {
//         AppCubit.get(context).updateData(status: 'done', id: model['id']);
//       } ,
//       icon: Icon(Icons.check_box,
//       color: Colors.blue,),
//   ),
//       IconButton(
//     onPressed:()
//     {
//       AppCubit.get(context).updateData(status: 'archive', id: model['id']);
//     } ,
//     icon: Icon(Icons.archive,
//     color: Colors.blueGrey,
//     ),
//   ),
//     ],
//   ),
// );
//
//
// //-------------------------------------------------------------------------------------------------




import 'package:flutter/material.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/shared/cubit/cubit.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required VoidCallback function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  VoidCallback? onTap,
  bool isPassword = false,
  required String? Function(String?) validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix,color: Colors.blue,),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixPressed,
          icon: Icon(suffix,color: Colors.blue,),
        )
            : null,
        border: const OutlineInputBorder(),
      ),
    );

Widget buildTaskItem(Task task, BuildContext context) => Dismissible(
  key: Key(task.id.toString()),
  onDismissed: (direction) {
    AppCubit.get(context).deleteData(id: task.id);
  },
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        CircleAvatar(
          child: Text(task.time,
            style: const TextStyle(
              color: Colors.white,
            )),
          radius: 40,
          backgroundColor: Colors.blueGrey,
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                task.date,
                style: const TextStyle(
                  color: Colors.blueGrey,
                ),
              )
            ],
          ),
        ),
        const SizedBox(width: 20.0),
        IconButton(
          onPressed: () {
            AppCubit.get(context).updateData(status: 'done', id: task.id);
          },
          icon: const Icon(
            Icons.check_box,
            color: Colors.blue,
          ),
        ),
        IconButton(
          onPressed: () {
            AppCubit.get(context).updateData(status: 'archive', id: task.id);
          },
          icon: const Icon(
            Icons.archive,
            color: Colors.blueGrey,
          ),
        ),
      ],
    ),
  ),
);