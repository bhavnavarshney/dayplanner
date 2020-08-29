import 'package:flutter/material.dart';
import 'package:day_planner/model/model.dart';
import 'package:day_planner/database/repository_service.dart';
import 'package:flutter_week_view/flutter_week_view.dart';
import 'dart:math';

class DailyPlan extends StatefulWidget {
  @override
  _DailyPlanState createState() => _DailyPlanState();
}

class _DailyPlanState extends State<DailyPlan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DayView() ,
      appBar: AppBar(
        title: Text("Daily Plan"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  title: Text("Add Task"),
                  content: TextField(
                    onChanged: (String value) {
                      //this.input = value;
                    },
                  ),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Add"),
                    ),
                  ],
                );
              });
        },
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Colors.purple,
      ),
    );
  }
}

class DayView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Let's get two dates :
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    // And here's our widget !
    return SingleChildScrollView(
      child: DayView(
        date: now,
        events: [
          FlutterWeekViewEvent(
            title: 'An event 1',
            description: 'A description 1',
            start: date.subtract(Duration(hours: 1)),
            end: date.add(Duration(hours: 18, minutes: 30)),
          ),
          FlutterWeekViewEvent(
            title: 'An event 2',
            description: 'A description 2',
            start: date.add(Duration(hours: 19)),
            end: date.add(Duration(hours: 22)),
          ),
          FlutterWeekViewEvent(
            title: 'An event 3',
            description: 'A description 3',
            start: date.add(Duration(hours: 23, minutes: 30)),
            end: date.add(Duration(hours: 25, minutes: 30)),
          ),
          FlutterWeekViewEvent(
            title: 'An event 4',
            description: 'A description 4',
            start: date.add(Duration(hours: 20)),
            end: date.add(Duration(hours: 21)),
          ),
          FlutterWeekViewEvent(
            title: 'An event 5',
            description: 'A description 5',
            start: date.add(Duration(hours: 20)),
            end: date.add(Duration(hours: 21)),
          ),
        ],
        style:  DayViewStyle.fromDate(
          date: now,
          currentTimeCircleColor: Colors.pink,
        ),
      ),
    );
  }
}

