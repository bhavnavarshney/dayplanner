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
  String status = "TaskNotAdded";

  completeGoal(Task g) async {
    await RepositoryService.deleteTask(g, this.tablename);
    setState(() {
      futureTask = RepositoryService.getAllTasks(this.tablename);
      futureTask.then((lists) {
        setState(() {
          this.taskList = lists;
          this.count = taskList.length;
        });
      });
    });
  }

  @override
  initState() {
    super.initState();
    this.futureTask = RepositoryService.getAllTasks(this.tablename);
    futureTask.then((taskList) {
      this.taskList = taskList;
      this.count = taskList.length;
    });
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CreateNewTaskPage(),
      ),
    );
    if (result=="TaskAdded") {
      setState(() {
        this.futureTask = RepositoryService.getAllTasks(this.tablename);
        futureTask.then((taskList) {
          this.taskList = taskList;
          this.count = taskList.length;
        });
      });
      getTasklist();
    }
  }

  ListView getTasklist() {
    return ListView.builder(
        itemCount: this.count,
        itemBuilder: (BuildContext ctx, int index) {
          return Center(
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Checkbox(
                        value: taskList[index].isDone,
                        onChanged: (bool newValue) {
                          setState(() {
                            taskList[index].isDone = newValue;
                            completeGoal(taskList[index]);
                          });
                        }),
                    title: Text(
                      '${this.taskList[index].name != null ? this.taskList[index].name : ""}',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Text(
                      this.taskList[index].description != null
                          ? this.taskList[index].description
                          : "",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black54,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  ButtonBar(
                    children: <Widget>[
                      Text(
                        "StartTime: ${this.taskList[index].startTime}",
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        "EndTime: ${this.taskList[index].endTime}",
                        style: TextStyle(
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    this.futureTask = RepositoryService.getAllTasks(this.tablename);
    futureTask.then((taskList) {
      this.taskList = taskList;
      this.count = taskList.length;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Look at your Day!",
          style: TextStyle(color: Colors.purple),
        ),
        backgroundColor: Colors.yellow,
      ),
      backgroundColor: Colors.white,
      body: Container(
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
                          fontSize: 30.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.purple),
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
                          _navigateAndDisplaySelection(context);
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
                 child:getTasklist(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
