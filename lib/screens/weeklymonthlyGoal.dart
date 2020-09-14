import 'package:flutter/material.dart';
import 'package:day_planner/model/model.dart';
import 'package:day_planner/database/repository_service.dart';

class Goals extends StatefulWidget {
  final String appTitle;

  Goals({Key key, this.appTitle}) : super(key: key);

  @override
  _GoalsState createState() => _GoalsState();
}

class _GoalsState extends State<Goals> {
  final _formKey = GlobalKey<FormState>();
  Future<List<Goal>> future;
  List<Goal> lists;
  String name;
  int id;
  String tablename;
  int count = 0;
  String input;
  bool checkboxValue = false;

  @override
  initState() {
    super.initState();
    if (widget.appTitle == "Weekly Goals") {
      tablename = "WeeklyGoals";
    } else if (widget.appTitle == "Monthly Goals") {
      tablename = "MonthlyGoals";
    } else if (widget.appTitle == "Yearly Goals") {
      tablename = "YearlyGoals";
    }
    this.future = RepositoryService.getAllGoals(tablename);
    future.then((lists) {
      setState(() {
        this.lists = lists;
        this.count = lists.length;
      });
    });
  }

  void readData() async {
    final todo = await RepositoryService.getGoals(id, this.tablename);
  }

  updateGoal(Goal g) async {
    await RepositoryService.updateGoalName(g, this.tablename);
    setState(() {
      future = RepositoryService.getAllGoals(this.tablename);
      future.then((lists) {
        setState(() {
          this.lists = lists;
          this.count = lists.length;
        });
      });
    });
  }

  deleteGoal(Goal g) async {
    await RepositoryService.deleteGoal(g, this.tablename);
    setState(() {
      id = null;
      future = RepositoryService.getAllGoals(this.tablename);
      future.then((lists) {
        setState(() {
          this.lists = lists;
          this.count = lists.length;
        });
      });
    });
  }

  completeGoal(Goal g) async {
    await RepositoryService.updateGoalStatus(g, this.tablename);
    setState(() {
      id = null;
      future = RepositoryService.getAllGoals(this.tablename);
      future.then((lists) {
        setState(() {
          this.lists = lists;
          this.count = lists.length;
        });
      });
    });
  }

  void createGoal(String text) async {
    int count = await RepositoryService.count(this.tablename);
    final goal = Goal(count, text, false);
    await RepositoryService.addGoal(goal, this.tablename);
    setState(() {
      id = null;
      future = RepositoryService.getAllGoals(this.tablename);
      future.then((lists) {
        setState(() {
          this.lists = lists;
          this.count = lists.length;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getGoalsListView(),
      appBar: AppBar(
        title: Text(widget.appTitle),
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
                      this.input = value;
                    },
                  ),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        createGoal(input);
                        Navigator.of(context).pop();
                        getGoalsListView();
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

  ListView getGoalsListView() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: count,
      itemBuilder: (context, i) {
        final item = lists[i];
        return Dismissible(
          key: Key(i.toString()),
          child: Card(
            elevation: 4,
            margin: EdgeInsets.all(0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: ListTile(
                leading: Checkbox(
                    value: item.isDone,
                    onChanged: (bool newValue) {
                      print('onChanged');
                      setState(() {
                        print(newValue);
                        item.isDone = newValue;
                        completeGoal(item);
                      });
                    }),
                title: Text(item.name),
                trailing:
                    Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.purple),
                    onPressed: () {
                      setState(() {
                        deleteGoal(item);
                      });
                    },
                  ),
                ])),
          ),
        );
      },
    );
  }
}
