import 'package:flutter/material.dart';
import 'package:day_planner/screens/sideNav.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.purple,
      accentColor: Colors.purple,
    ),
    home: SideBar(),
));