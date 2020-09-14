
import 'package:flutter/material.dart';
class TaskDisplay extends StatefulWidget {
  String title;
  String subtitle;
  Color boxColor;
  String startTime;
  String endTime;
  bool isCompleted;

  TaskDisplay({
    this.title, this.subtitle, this.boxColor, this.startTime,this.endTime, this.isCompleted
  });

  @override
  _TaskDisplayState createState() => _TaskDisplayState();
}

class _TaskDisplayState extends State<TaskDisplay> {
  String title;
   String subtitle;
   Color boxColor;
   String startTime;
  String endTime;
  bool isCompleted;

  _TaskDisplayState({
    this.title, this.subtitle, this.boxColor, this.startTime,this.endTime, this.isCompleted
  });


  void _onRememberMeChanged(bool newValue)  {
    this.isCompleted = newValue;

    if (isCompleted) {
      // TODO: Here goes your functionality that remembers the user.
    } else {
      // TODO: Forget the user
    }
  }

  @override
  Widget build(BuildContext context) {
    print('In task ${this.title}');
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.0),
      padding: EdgeInsets.all(20.0),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Text(
      '${this.title != null ? this.title : ""}',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
//              Checkbox(
//                  value: isCompleted,
//                  onChanged: _onRememberMeChanged
//              ),
            ],
          ),


          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              this.subtitle != null ? this.subtitle : "",
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black54,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
          color: boxColor,
          borderRadius: BorderRadius.circular(30.0)),
    );
  }
}