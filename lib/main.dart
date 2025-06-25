import 'package:flutter/material.dart';
import 'package:todo/layout/home_layot.dart';
import 'package:todo/modules/counter.dart';

//import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/shared/blocobserver.dart';




void main() {
  blocobserver: MyBlocObserver();

  //databaseFactory = databaseFactoryFfi;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      //home: HomeLayout(),
      home: CountScreen(),
    );
  }
}
