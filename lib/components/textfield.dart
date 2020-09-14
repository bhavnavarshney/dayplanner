
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyTextFieldTime extends StatelessWidget {
  final String label;
  final int maxLines;
  final int minLines;
  final Icon icon;
  MyTextFieldTime({this.label, this.maxLines = 1, this.minLines = 1, this.icon});


  @override
  Widget build(BuildContext context) {
    TimeOfDay time = TimeOfDay.now();
    TextEditingController timeCtl = TextEditingController();

    _pickTime() async {
      TimeOfDay t = await showTimePicker(
          context: context,
          initialTime: time,
      );
      if(t != null) {
          time = t;
          print(time);
          timeCtl.text = time.format(context).toString();
      }
    }

    return TextFormField(
      controller: timeCtl,
      style: TextStyle(color: Colors.black87),
      minLines: minLines,
      maxLines: maxLines,
      decoration: InputDecoration(
          suffixIcon: icon == null ? null: icon,
          labelText: label,
          labelStyle: TextStyle(color: Colors.black45),

          focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          border:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
      onTap: _pickTime,
    );
  }
}

class MyTextFieldDate extends StatelessWidget {
  final String label;
  final int maxLines;
  final int minLines;
  final Icon icon;
  MyTextFieldDate({this.label, this.maxLines = 1, this.minLines = 1, this.icon});

  TextEditingController timeCtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DateTime pickedDate = DateTime.now();

    _pickDate() async {
      DateTime date = await showDatePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year-5),
        lastDate: DateTime(DateTime.now().year+5),
        initialDate: pickedDate,
      );
      if(date != null)
        pickedDate = date;
         var now = DateTime.now();
         print(pickedDate);
         print(now);
        var dt = DateTime(now.year, now.month, now.day,pickedDate.hour,pickedDate.second);
        String _formattetime = DateFormat.Hm().format(dt);
        timeCtl.text = _formattetime;
        print(_formattetime);
    }

    return TextFormField(
      controller: timeCtl,
      style: TextStyle(color: Colors.black87),
      minLines: minLines,
      maxLines: maxLines,
      decoration: InputDecoration(
          suffixIcon: icon == null ? null: icon,
          labelText: label,
          labelStyle: TextStyle(color: Colors.black45),

          focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          border:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
      onTap: _pickDate,
    );
  }
}


class MyTextField extends StatelessWidget {
  final String label;
  final int maxLines;
  final int minLines;
  final Icon icon;
  MyTextField({this.label, this.maxLines = 1, this.minLines = 1, this.icon});

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      style: TextStyle(color: Colors.black87),
      minLines: minLines,
      maxLines: maxLines,
      decoration: InputDecoration(
          suffixIcon: icon == null ? null: icon,
          labelText: label,
          labelStyle: TextStyle(color: Colors.black45),

          focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          border:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
     // onChanged: ,
    );
  }
}

