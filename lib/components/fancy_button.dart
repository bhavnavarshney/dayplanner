
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:day_planner/screens/dailyplan.dart';

class FancyButton extends StatelessWidget {

  FancyButton({@required this.onPressed});
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text("Added Task in the To-Do!");
  }
}