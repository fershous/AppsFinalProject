import 'dart:io';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final String tableTasks = 'tasks';

final String columnId = 'id';
final String columnType = 'type';
final String columnTitle = 'title';
final String columnDescription = 'description';
final String columnPlace = 'place';
final String columnDate = 'date';

class Task {

  int? id;
  int type = 1;
  String? title;
  String? description;
  int? date;
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
      columnType: type,
      columnTitle: title,
      columnDescription: description,
      columnDate: date,
      columnPlace: place,
    };
    return map;
  }

}

class DatabaseController extends GetxController {

  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 2;

  final _formatter = DateFormat('EEE, dd-MM');

  final tasks = Future.value(<Task>[]).obs;
  var len = 0.obs;
  var tipo = 0.obs;
  int count = 0;

  static Database? _database;
  Future<Database?> get database async {
    if(_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }
  
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);

    print(path);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate
    );
  }

  Future _onCreate(Database db, int verison) async {
    await db.execute('''
      CREATE TABLE $tableTasks (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnType INTEGER NOT NULL,
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
    
    String today = _formatter.format(DateTime.now());
    String taskdate = _formatter.format(DateTime.fromMillisecondsSinceEpoch(task.date!));
    if(today == taskdate) count+=1;

    getTasks(task.type);
    return id;
  }

  void getTasks (int type) async {
    tasks.value = queryTask(type);
    tipo.value = type;
    update();
  }

  Future<int> queryAll() async {
    count = 0;
    Database db = (await database)!;
    List<Map<String, dynamic>> maps = await db.query(tableTasks,
      columns: [columnType, columnId, columnTitle, columnDescription, columnPlace, columnDate],
    );
    maps.forEach((task) { 
      Task t = Task.fromMap(task);
      String today = _formatter.format(DateTime.now());
      String taskdate = _formatter.format(DateTime.fromMillisecondsSinceEpoch(t.date!));
      if(today == taskdate) count+=1;
     });
    return count;
  }

  Future<List<Task>> queryTask(int type) async {
    List<Task> tasks = [];
    Database db = (await database)!;
    List<Map<String, dynamic>> maps = await db.query(tableTasks,
      columns: [columnType, columnId, columnTitle, columnDescription, columnPlace, columnDate],
      where: '$columnType = ?',
      whereArgs: [type]
    );
    if(maps.length > 0) {
      maps.forEach((map) => tasks.add(Task.fromMap(map)));
      len.value = tasks.length;
      return tasks;
    }
    return [];
  }

  Future<int> deleteTask(int id) async {
    Database db = (await database)!;
    return db.delete(
      tableTasks,
      where: '$columnId = ?',
      whereArgs: [id]
    );
  }

  Future<int> deleteAll() async {
    Database db = (await database)!;
    return db.delete(tableTasks, where: null);
  }

}