import 'package:flutter/material.dart';
import 'package:day_planner/screens/weeklymonthlyGoal.dart';

class SideBar extends StatelessWidget {
  final appTitle = 'My DayPlanner';

  //SideBar({Key key, this.appTitle}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appTitle),),
      body: Goals(),
      drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('My DayPlanner',
                  style: TextStyle(
                    color: Colors.white,
                  ),),
                decoration: BoxDecoration(
                  color: Colors.purple,
                ),
              ),
              ListTile(
                title: Text('Daily Plan'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Weekly Goals'),
                onTap: () {
                  Goals(appTitle: 'Weekly Goals',);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Monthly Goals'),
                onTap: () {
                  Goals(appTitle: 'Montly Goals',);
                  Navigator.pop(context);
                },
              )
            ],
          )
      ),
    );
  }
}