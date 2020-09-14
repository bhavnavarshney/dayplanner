import 'package:day_planner/screens/dailyplan.dart';
import 'package:flutter/material.dart';
import 'package:day_planner/components/topcontainer.dart';
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
  String startTime;
  String endTime;
  String date;
  String description;

  void createTask() async {
    int count = await RepositoryService.count(this.tablename);
    final task = Task(count, this.title, this.description, false,this.startTime,this.endTime,this.date);
    await RepositoryService.addTask(task, this.tablename);
  }

  @override
  Widget build(BuildContext context) {
    _pickStartTime() async {
      TimeOfDay t = await showTimePicker(
        context: context,
        initialTime: time,
      );
      if(t != null) {
        time = t;
        print(time);
        timeCtl.text = time.format(context).toString();
        startTime = timeCtl.text;
      }
    }

    _pickEndTime() async {
      TimeOfDay t = await showTimePicker(
        context: context,
        initialTime: time,
      );
      if(t != null) {
        time = t;
        print(time);
        timeCtl.text = time.format(context).toString();
        endTime = timeCtl.text;
      }
    }

    double width = MediaQuery.of(context).size.width;
    var downwardIcon = Icon(
      Icons.keyboard_arrow_down,
      color: Colors.black54,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Create New Task"),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopContainer(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
              width: width,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Your Task',
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                      TextFormField(
                      style: TextStyle(color: Colors.black87),
                    minLines: 1,
                    maxLines: 1,
                    decoration: InputDecoration(
                        //suffixIcon: icon == null ? null: icon,
                        labelText: 'Title',
                        labelStyle: TextStyle(color: Colors.black45),

                        focusedBorder:
                        UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                        border:
                        UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
                        onChanged: (String value) {
                          this.title = value;
                        },
                  ),
//                          Row(
//                            mainAxisAlignment: MainAxisAlignment.start,
//                            crossAxisAlignment: CrossAxisAlignment.end,
//                            children: <Widget>[
//                              Expanded(
//                                child: MyTextFieldDate(
//                                  label: 'Date',
//                                  icon: downwardIcon,
//                                ),
//
//                              ),
//                              //DailyPlan.calendarIcon(),
//                            ],
//                          )
                      ],
                      ))
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              controller: timeCtl,
                              style: TextStyle(color: Colors.black87),
                              minLines: 1,
                              maxLines: 1,
                              decoration: InputDecoration(
                                 // suffixIcon: icon == null ? null: icon,
                                  labelText: 'Start Time',
                                  labelStyle: TextStyle(color: Colors.black45),

                                  focusedBorder:
                                  UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                  border:
                                  UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
                              onTap: _pickStartTime,
                          ),
                          ),
                          SizedBox(width: 40),
                          Expanded(
                              child: TextFormField(
                                controller: timeCtl,
                                style: TextStyle(color: Colors.black87),
                                minLines: 1,
                                maxLines: 1,
                                decoration: InputDecoration(
                                    //suffixIcon: icon == null ? null: icon,
                                    labelText: 'End Time',
                                    labelStyle: TextStyle(color: Colors.black45),

                                    focusedBorder:
                                    UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                    border:
                                    UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
                                onTap: _pickEndTime,
                              ),
                              ),
                        ],
                      ),
                      SizedBox(height: 20),
                  TextFormField(
                    style: TextStyle(color: Colors.black87),
                    minLines: 1,
                    maxLines: 1,
                    decoration: InputDecoration(
                        //suffixIcon: icon == null ? null: icon,
                        labelText: 'Description',
                        labelStyle: TextStyle(color: Colors.black45),

                        focusedBorder:
                        UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                        border:
                        UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
                    onChanged: (String value) {
                      this.description = value;
                    },
                  ),
                    ],
                  ),
                )),
            Container(
              height: 80,
              width: width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    child: RaisedButton(child: Text(
                      'Create Task'),
                      onPressed: (){
                        print('Task Creating');
                        createTask();
                        print('Task Created');
                        Navigator.push(context,MaterialPageRoute(builder: (context) => DailyPlan()));
                      },
                    ),
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                    width: width - 40,
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}