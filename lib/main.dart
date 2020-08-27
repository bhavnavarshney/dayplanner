import 'package:flutter/material.dart';
import 'package:day_planner/screens/sideNav.dart';
import 'package:day_planner/database/db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseCreator().initDatabase();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'My DayPlanner',
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.purple,
      accentColor: Colors.purple,
    ),
    home: SideBar(),
  ));
}