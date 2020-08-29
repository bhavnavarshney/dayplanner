import 'package:day_planner/database/db.dart';
import 'package:flutter/material.dart';

class Goal {
  int id;
  String name;
  bool isDone;

  Goal(this.id, this.name, this.isDone);

  Goal.fromJson(Map<String, dynamic> json) {
    this.id = json[DatabaseCreator.id];
    this.name = json[DatabaseCreator.name];
    this.isDone = json[DatabaseCreator.isDone] == 1;
  }

//  Map<String,dynamic> toMap() => {
//    "id":id,
//    "name":name,
//  };
//
//  factory Goal.fromMap(Map<String,dynamic> json) => new Goal(
//    id : json["id"],
//    text: json["text"]
//  );
}


