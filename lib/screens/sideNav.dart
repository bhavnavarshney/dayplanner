import 'package:day_planner/screens/addTask.dart';
import 'package:flutter/material.dart';
import 'package:day_planner/screens/weeklymonthlyGoal.dart';
import 'package:day_planner/screens/dailyplan.dart';

class SideBar extends StatelessWidget {
  final appTitle = 'My DayPlanner';

  //SideBar({Key key, this.appTitle}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appTitle),),
      body: DailyPlan(),
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
                  Navigator.push(context,MaterialPageRoute(builder: (context) => DailyPlan()));
                },
              ),
              ListTile(
                title: Text('Weekly Goals'),
                onTap: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => Goals(appTitle: 'Weekly Goals',)));
                },
              ),
              ListTile(
                title: Text('Monthly Goals'),
                onTap: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => Goals(appTitle: 'Monthly Goals',)));
                },
              ),
              ListTile(
                title: Text('Yearly Goals'),
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => Goals(appTitle: 'Yearly Goals',)));
                },
              )
            ],
          )
      ),
    );
  }
}