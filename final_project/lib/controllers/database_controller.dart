import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final String tableTasks = 'tasks';

final String columnId = 'id';
final String columnType = 'type';
final String columnTitle = 'title';
final String columnDescription = 'id';
final String columnPlace = 'place';
final String columnDate = 'date';

class Task {

  int? id;
  int? type;
  String? title;
  String? description;
  DateTime? date;
  String? place;

  Task();

  Task.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    type = map[columnType];
    title = map[columnTitle];
    description = map[columnDescription];
    place = map[columnPlace];
    date = map[columnDate];
  }

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      columnId: id,
      columnTitle: title,
      columnDescription: description,
      columnDate: date,
      columnPlace: place,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

}

class DatabaseHelper {

  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  static Database? _database;
  Future<Database?> get database async {
    if(_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }
  
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate
    );
  }

  Future _onCreate(Database db, int verison) async {
    await db.execute('''
      CREATE TABLE $tableTasks (
        $columnId INTEGER PRIMARY KEY,
        $columnId INTEGER NOT NULL,
        $columnTitle TEXT NOT NULL,
        $columnDescription TEXT NOT NULL,
        $columnDate INTEGER NOT NULL,
        $columnPlace TEXT NOT NULL
      )
    ''');
  }

  Future<int> insert(Task task) async {
    Database? db = await database;
    int id = await db!.insert(tableTasks, task.toMap());
    return id;
  }

  Future<List<Task>?> queryTask(int type) async {
    Database? db = await database;
    List<Map<String, dynamic>> maps = await db!.query(tableTasks,
      columns: [columnType, columnId, columnTitle, columnDescription, columnPlace, columnDate],
      where: '$columnType = ?',
      whereArgs: [type]
    );
    if(maps.length > 0) {
      List<Task> tasks = [];
      maps.forEach((map) => tasks.add(Task.fromMap(map)));
      return tasks;
    }
    return null;
  }

}