import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:final_project/controllers/unsplash_controller.dart';
import 'package:final_project/controllers/database_controller.dart';

import 'package:final_project/dialogs/task_dialog.dart';

final unsplashController = Get.find<UnsplashController>();
final databaseController = Get.find<DatabaseController>();

final DateFormat _dateFormatter = DateFormat('EEE, dd-MM'); 
final DateFormat _timeFormatter = DateFormat('Hm');

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    print('Arguments: ${databaseController.tipo.value}');

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Get.dialog(
            TasksDialog(),
            arguments: databaseController.tipo.value,
            barrierDismissible: false
          )
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(46, 197, 206, 1.0),
      ),
      // This thing build a CircularProgressIndicator while the Query for the tasks
      // is running. After that, it will return a CustomScrollView with a list of tasks
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            AppBar()
          ];
        }, 
        body: GetX<DatabaseController>(
          init: DatabaseController(),
          builder: (databaseController) {
            return FutureBuilder(
              future: databaseController.tasks.value,
              builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.25,
                        child: TaskWidget(snapshot: snapshot.data![index]),
                        actions: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: IconSlideAction(
                              caption: 'Eliminar',
                              color: Colors.red,
                              icon: Icons.delete,
                              onTap: () => {
                                databaseController.deleteTask(snapshot.data![index].id!),
                                databaseController.getTasks(databaseController.tipo.value),
                                databaseController.queryAll()
                              }
                            ),
                          )
                        ],
                        secondaryActions: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: IconSlideAction(
                              caption: 'Completar',
                              color: Colors.blue,
                              icon: Icons.done,
                              onTap: () => {
                                databaseController.deleteTask(snapshot.data![index].id!),
                                databaseController.getTasks(databaseController.tipo.value),
                                databaseController.queryAll()
                              }
                            ),
                          )
                        ],
                      );
                    }
                  );
                }
                else return CircularProgressIndicator();
              },
            );
          }
        ),
      )
    );
  }
}

class TaskWidget extends StatelessWidget {

  final Task snapshot;

  const TaskWidget({
    Key? key, required this.snapshot
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String _date = _dateFormatter.format(DateTime.fromMillisecondsSinceEpoch(snapshot.date!));
    String _time = _timeFormatter.format(DateTime.fromMillisecondsSinceEpoch(snapshot.date!));

    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            snapshot.title!, 
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24)),
          SizedBox(height: 5),
          Row(
            children: <Widget>[
              Text(_date + ' ' + _time),
              Spacer(),
              Text(snapshot.place!, style: TextStyle(fontWeight: FontWeight.bold),)
            ],
          )
        ]
      )
    );
  }
}

class AppBar extends StatelessWidget {
  const AppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.transparent,
      expandedHeight: 175,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: 'img',
          child: Image.network(
            unsplashController.getUrl(),
            fit: BoxFit.cover,
          ),
        )
      )
    );
  }
}