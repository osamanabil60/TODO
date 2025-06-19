import 'package:flutter/material.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required VoidCallback function,
  required String text,
}) => Container(
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
}) => TextFormField(
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
    prefixIcon: Icon(prefix),
    suffixIcon: suffix != null
        ? IconButton(
      onPressed: suffixPressed,
      icon: Icon(suffix),
    )
        : null,
    border: const OutlineInputBorder(),
  ),
);
//------------------------------------------------------------------------------/
//TextFormField defaultFormField({
  //required TextEditingController controller,
  //required TextInputType type,
 // required String?Function(String?) validate,  // Changed this line
 // required String label,
//  required IconData prefix,
  //void Function()? onTap,
///}) => TextFormField(
  //controller: controller,
  //keyboardType: type,
  //validator: validate,  // Removed the parentheses
 // onTap: onTap,
 // decoration: InputDecoration(
//    labelText: label,
 //   prefixIcon: Icon(prefix),
//    border: OutlineInputBorder(),
//  ),
//);
//-----------------------------------------------------------