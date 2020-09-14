import 'package:day_planner/screens/addTask.dart';
import 'package:flutter/material.dart';
import 'package:day_planner/model/model.dart';
import 'package:day_planner/components/tasks.dart';
import 'package:intl/intl.dart';
import 'package:day_planner/database/repository_service.dart';

class DailyPlan extends StatefulWidget {
  @override
  _DailyPlanState createState() => _DailyPlanState();
}

class _DailyPlanState extends State<DailyPlan> {
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  List<Task> taskList;
  Future<List<Task>> futureTask;
  final String tablename = "DailyGoals";
  int count = 0;

  @override
  initState() {
    super.initState();
    print('DailyPlan: Init called');
    this.futureTask = RepositoryService.getAllTasks(this.tablename);
    futureTask.then((taskList) {
        this.taskList = taskList;
        this.count = taskList.length;
      });
    print('TaskList: $taskList[0].name');
    print(taskList.length);
  }


  @override
  Widget build(BuildContext context) {
    this.futureTask = RepositoryService.getAllTasks(this.tablename);
    futureTask.then((taskList) {
      this.taskList = taskList;
      this.count = taskList.length;
    });
    print(taskList[0].name);
    print(count);
    return Scaffold(
      appBar: AppBar(
        title: Text('DayPlanner'),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            20,
            20,
            0,
          ),
          child: Column(
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Today',
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.w700),
                    ),
                    Container(
                      height: 40.0,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateNewTaskPage(),
                            ),
                          );
                        },
                        child: Center(
                          child: Text(
                            'Add task',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ]),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Design your Day!',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  formatter.format(now),
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: ListView.builder(
                            itemCount: count,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) =>
                                Card(
                                  color: Colors.lightGreenAccent,
                                  shadowColor: Colors.green,
                                  child: ListTile(
                                    leading: Checkbox(
                                      value: taskList[index].isDone,
                                      onChanged: (bool newValue) {
                                        print('onChanged');
                                        setState(() {
                                          print(newValue);
                                          taskList[index].isDone = newValue;
                                          //completeGoal(item);
                                        });
                                      }),
                                    title: Text(
                                      '${this.taskList[index].name != null ? this.taskList[index].name  : ""}',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        this.taskList[index].description != null ? this.taskList[index].description : "",
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    trailing: Row(),
                                  ),
                                ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}