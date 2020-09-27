import 'package:day_planner/components/fancy_button.dart';
import 'package:day_planner/screens/dailyplan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:day_planner/model/model.dart';
import 'package:day_planner/database/repository_service.dart';

class CreateNewTaskPage extends StatefulWidget {
  @override
  _CreateNewTaskPageState createState() => _CreateNewTaskPageState();
}

class _CreateNewTaskPageState extends State<CreateNewTaskPage> {
  final String tablename = "DailyGoals";
  String title;
  TimeOfDay time = TimeOfDay.now();
  TextEditingController timeCtl = TextEditingController();
  TextEditingController timeCtl2 = TextEditingController();
  String startTime;
  String endTime;
  String date;
  String description;
  final format = DateFormat("dd-MM-yyyy HH:mm");

  void createTask(BuildContext context) async {
    int count = await RepositoryService.count(this.tablename);
    this.date = DateTime.now().toString();
    final task = Task(count, this.title, this.description, false,this.startTime,this.endTime,this.date);
    await RepositoryService.addTask(task, this.tablename);
    print("Task is created now");
    print("CreateTask call done");
    Navigator.pop(context, "TaskAdded");
  }

//  void submit() async {
//    await createTask();
//  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text("Add Task"),),
        body: SingleChildScrollView(
          child: Center(child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 20,),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.assignment,color: Colors.purple,),
                  hintText: 'Add Title here',
                  labelText: 'Title *',
                ),
                onChanged: (String val){
                  this.title = val;
                },
              ),
              SizedBox(height: 20,),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.description,color: Colors.purple,),
                  hintText: 'Add Description here',
                  labelText: 'Description',
                ),
                onChanged: (String val){
                  this.description = val;
                },
              ),
              SizedBox(height: 20,),
              DateTimeField(
                format: format,
                  decoration: InputDecoration(
                    icon: Icon(Icons.alarm,
                    color: Colors.purple,
                    ),
                    labelText: 'Start : Date and Time',
                  ),
                onShowPicker: (context, currentValue) async {
                  final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                  if (date != null) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime:
                      TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                    );
                    this.startTime = DateTimeField.combine(date, time).toString();
                    print(this.startTime);
                    return DateTimeField.combine(date, time);
                  } else {
                    this.startTime = currentValue.toString();
                    return currentValue;
                  }
                },
              ),
              DateTimeField(
                format: format,
                decoration: InputDecoration(
                  icon: Icon(Icons.alarm,
                  color: Colors.purple,
                  ),
                  labelText: 'End : Date and Time',
                ),
                onShowPicker: (context, currentValue) async {
                  final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                  if (date != null) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime:
                      TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                    );
                    this.endTime = DateTimeField.combine(date, time).toString();
                    print(this.endTime);
                    return DateTimeField.combine(date, time);
                  } else {
                    this.endTime = currentValue.toString();
                  }
                },
              ),
              SizedBox(height: 30,),
              RaisedButton(
                onPressed: () {
                  createTask(context);
                },
                textColor: Colors.white,
                //padding: const EdgeInsets.all(0.0),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                  ),
                  //padding: const EdgeInsets.all(10.0),
                  child:
                  const Text('Save', style: TextStyle(fontSize: 20)),
                ),
              ),
            ],
          ),
        ),
        ),
      );
  }

}