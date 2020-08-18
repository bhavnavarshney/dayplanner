import 'dart:io';

import 'package:day_planner/model/model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider{
  DBProvider._();
  static final DBProvider db = new DBProvider._();
  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await getWeeklyGoalDatabaseInstance();
    return _database;
  }

  Future<Database> getWeeklyGoalDatabaseInstance() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "dayplanner.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE WeeklyGoals ("
              "id integer primary key AUTOINCREMENT,"
              "goal TEXT"
              ")");
        });
  }
    // Get all the weekly goals from DB
    Future<List<Goal>> getAllWeeklyGoals() async {
      final db = await database;
      var response = await db.query("WeeklyGoals");
      List<Goal> list = response.map((c) => Goal.fromMap(c)).toList();
      return list;
    }

   addWeeklyGoalToDatabase(Goal g) async {
    final db = await database;
    var raw = await db.insert("WeeklyGoals",
      g.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return raw;
  }

  deleteWeeklyGoal(int id) async {
    final db = await database;
    return db.delete("WeeklyGoals", where: "id = ?", whereArgs: [id]);
  }
  }