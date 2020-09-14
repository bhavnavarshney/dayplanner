import 'dart:io';

import 'package:day_planner/model/model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

Database db;

class DatabaseCreator {
  static const weekly = 'WeeklyGoals';
  static const monthly = 'MonthlyGoals';
  static const daily = 'DailyGoals';
  static const yearly = 'YearlyGoals';

  static const id = 'id';
  static const name = 'name';
  static const isDone = 'isDone';
  static const startTime = 'startTime';
  static const endTime = 'endTime';
  static const date = 'date';
  static const description='description';

  static void databaseLog(String funcName, String sql,
      [List<Map<String, dynamic>> selectQueryResult,
      int insertUpdateQueryResult]) {
    print(funcName);
    print(sql);
    if (selectQueryResult != null) {
      print(selectQueryResult);
    } else if (insertUpdateQueryResult != null) {
      print(insertUpdateQueryResult);
    }
  }

  Future<void> createTable(Database db, String tablename) async {
    final tableSQL = '''CREATE TABLE $tablename
    (
      $id INTEGER PRIMARY KEY,
      $name TEXT,
      $isDone BIT NOT NULL
    )''';
    await db.execute(tableSQL);
  }

  Future<void> createDailyTable(Database db, String tablename) async {
    final tableSQL = '''CREATE TABLE $tablename
    (
      $id INTEGER PRIMARY KEY,
      $name TEXT,
      $description TEXT,
      $isDone BIT NOT NULL,
      $startTime TEXT,
      $endTime TEXT,
      $date TEXT
    )''';
    await db.execute(tableSQL);
    print('Created table Daily');
  }

  Future<String> getDatabasePath(String dbName) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);

    //check if folder exists
    if (await Directory(dirname(path)).exists()) {
      //await deleteDatabase(path);
    } else {
      await Directory(dirname(path)).create(recursive: true);
    }
    return path;
  }

  Future<void> initDatabase() async {
    print("initDatabase");
    final path = await getDatabasePath('dayplanner_db');
    db = await openDatabase(path, version: 1, onCreate: onCreate);
    print(db);
  }

  Future<void> onCreate(Database db, int version) async {
    await createTable(db, weekly);
    await createTable(db, monthly);
    await createTable(db, yearly);
    await createDailyTable(db, daily);
  }
}
