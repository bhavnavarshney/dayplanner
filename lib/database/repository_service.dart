import 'dart:io';

import 'package:flutter/material.dart';

import 'package:day_planner/model/model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:day_planner/database/db.dart';

class RepositoryService {
  static Future<List<Goal>> getAllGoals(String tablename) async {
    final sql = ''' SELECT * FROM $tablename
    ''';
    final data = await db.rawQuery(sql);
    List<Goal> goals = List();
    for (final node in data) {
      final todo = Goal.fromJson(node);
      goals.add(todo);
    }
    return goals;
  }

  static Future<List<Task>> getAllTasks(String tablename) async {
    final sql = ''' SELECT * FROM $tablename order by date asc 
    ''';
    final data = await db.rawQuery(sql);
    List<Task> tasks = List();
    for (final node in data) {
      final todo = Task.fromJson(node);
      tasks.add(todo);
    }
    print('RepositoryService:$sql,$data,$tasks');
    return tasks;
  }

  static Future<Goal> getGoals(int id, String tablename) async {
    final sql = '''SELECT * FROM $tablename
    WHERE $tablename.id==$id''';
    final data = await db.rawQuery(sql);

    final goal = Goal.fromJson(data[0]);
    return goal;
  }

  static Future<Task> getTasks(int id, String tablename) async {
    final sql = '''SELECT * FROM $tablename
    WHERE $tablename.id==$id''';
    final data = await db.rawQuery(sql);
    print('Select Query Data: $data');
    final task = Task.fromJson(data[0]);
    return task;
  }

  static Future<Goal> deleteGoal(Goal g, String tablename) async {
    final sql = '''DELETE FROM $tablename
    WHERE id = ?
    ''';
    List<dynamic> params = [g.id];
    final result = await db.rawDelete(sql, params);
  }

  static Future<Task> deleteTask(Task g, String tablename) async {
    final sql = '''DELETE FROM $tablename
    WHERE id = ?
    ''';
    List<dynamic> params = [g.id];
    final result = await db.rawDelete(sql, params);
  }

  static Future<void> addGoal(Goal g, String tablename) async {
    final sql = '''INSERT INTO $tablename
    (
      id,
      name,
      isDone
    )
    VALUES (?,?,?)''';
    List<dynamic> params = [g.id, g.name, g.isDone ? 1 : 0];
    final result = await db.rawInsert(sql, params);
  }


  static Future<void> addTask(Task g, String tablename) async {
    final sql = '''INSERT INTO $tablename
    (
      id,
      name,
      description,
      isDone,
      startTime,
      endTime,
      date
    )
    VALUES (?,?,?,?,?,?,?)''';
    List<dynamic> params = [g.id, g.name,g.description, g.isDone ? 1 : 0,g.startTime,g.endTime,g.date];
    final result = await db.rawInsert(sql, params);
    print("AddTask Status : $result");
  }

  static Future<void> updateGoalStatus(Goal g, String tablename) async {
    final sql = '''UPDATE $tablename
    SET isDone = ?
    WHERE id = ?
    WHERE id = ?
    ''';
    List<dynamic> params = [g.isDone, g.id];
    final result = await db.rawUpdate(sql, params);

    DatabaseCreator.databaseLog('Delete todo', sql, null, result);
  }


  static Future<void> updateTaskStatus(Task g, String tablename) async {
    final sql = '''UPDATE $tablename
    SET isDone = ?
    WHERE id = ?
    ''';
    List<dynamic> params = [g.isDone, g.id];
    final result = await db.rawUpdate(sql, params);

    DatabaseCreator.databaseLog('Delete task', sql, null, result);
  }

  static Future<void> updateGoalName(Goal g, String tablename) async {
    final sql = '''UPDATE $tablename
    SET $tablename.name = "g.name"
    WHERE $tablename.id == g.id
    ''';
    final result = await db.rawUpdate(sql);
    DatabaseCreator.databaseLog("Update Goal Name", sql, null, result);
  }


  static Future<void> updateTaskName(Task g, String tablename) async {
    final sql = '''UPDATE $tablename
    SET $tablename.name = "g.name"
    WHERE $tablename.id == g.id
    ''';
    final result = await db.rawUpdate(sql);
    DatabaseCreator.databaseLog("Update Goal Name", sql, null, result);
  }

  static Future<int> count(String tablename) async {
    final data = await db.rawQuery('''
    SELECT COUNT(*) from $tablename
    ''');

    int count = data[0].values.elementAt(0);
    return count;
  }

}
