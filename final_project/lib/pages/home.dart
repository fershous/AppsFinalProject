
import 'package:final_project/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'dart:async';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:delayed_display/delayed_display.dart';

import 'package:final_project/controllers/auth_controller.dart';
import 'package:final_project/controllers/database_controller.dart';
import 'package:final_project/controllers/unsplash_controller.dart';

import 'package:final_project/dialogs/task_dialog.dart';
import 'package:unsplash_client/unsplash_client.dart';

final unsplashController = Get.find<UnsplashController>();
final dataBaseController = Get.find<DatabaseController>();
final authController     = Get.find<AuthController>();

final DateFormat _dateFormatter = DateFormat('EEE, dd-MM'); 
final DateFormat _timeFormatter = DateFormat('Hm'); 

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            margin: EdgeInsets.only(left: 10),
            child: HeaderWidget()
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () => _showNotification(),
              icon: Icon(Icons.notifications_none, color: Colors.black),
            ),
            SizedBox(width:15)
          ],
          bottom: TabBar(
            labelColor: Colors.black,
            tabs: <Tab>[
              Tab(text: 'Escuela',),
              Tab(text: 'Trabajo',),
              Tab(text: 'Hogar'),
              Tab(text: 'Otro',),
            ]
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: TabBarView(
          children: <Widget>[
            Container(
              child: Container(
                child: BodyWidget(id:1)
              )
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10), 
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: BodyWidget(id:2)
              )
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10), 
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: BodyWidget(id:3)
              )
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10), 
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: BodyWidget(id:4)
              )
            ),
          ],
        ),
      ),
    );
  }
}

class BodyWidget extends StatelessWidget {

  final int id;

  const BodyWidget({
    Key? key, required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Timer(Duration(milliseconds: 250), () {
      databaseController.getTasks(id);
    });

    _setImage();

    return SafeArea(
      child: Column(
        children: [
          SizedBox( height: 10 ),
          ImageContainer(),
          SizedBox(height: 20,),
          Expanded(
            child: DelayedDisplay(
              delay: Duration(milliseconds: 250),
              child: GetX<DatabaseController>(
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
                                      databaseController.getTasks(id),
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
                                      databaseController.getTasks(id),
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
            ),
          )
        ],
      ),
    );
  }

  void _setImage() async {

    late String collection;

    final client = UnsplashClient(
      settings: ClientSettings(
        credentials: AppCredentials(
          accessKey: 'sgREAtZ1Njqlw7w-9oQhK5NrMhBBJ1S84JzBe6dl8S0',
          secretKey: 'Nu9aqUEnDWY43Th51-VaPLVg42ul_4sJZk0xUG28tfs'
        )
      )
    );

    switch (id) {
      case 1: collection = '34294057'; break;
      case 2: collection = '472933'; break;
      case 3: collection = '416011'; break;
      case 4: collection = '1097194'; break;
    }

    print(collection);

    final photo = await client.photos.random(
      collections: ['$collection'],
      count: 1,
    ).goAndGet();

    unsplashController.saveUrl(photo[0].urls.small.toString());

    client.close();
  }
}

class TaskWidget extends StatelessWidget {

  final Task snapshot;

  const TaskWidget({
    Key? key, required this.snapshot
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final day = _dateFormatter.format(DateTime.now());
    final snap = _dateFormatter.format(DateTime.fromMillisecondsSinceEpoch(snapshot.date!));

    if(day == snap) {

      return GestureDetector(
        onTap: () => {
          showDialog(
            context: context, 
            barrierDismissible: false,
            builder: (BuildContext context) {
              return TasksDialog();
            }
          )
        },
        child: TaskContent(snapshot: snapshot),
      );
    }
    else return Container();

  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Hola,', style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 24.0
        ),),
        Text(authController.getUser.displayName!, style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 30.0
        ),),
      ],
    );
  }
}

class TaskContent extends StatelessWidget {

  final Task snapshot;

  const TaskContent({
    Key? key, required this.snapshot
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String _date = _dateFormatter.format(DateTime.fromMillisecondsSinceEpoch(snapshot.date!));
    String _time = _timeFormatter.format(DateTime.fromMillisecondsSinceEpoch(snapshot.date!));

    return Container(
      margin: EdgeInsets.all(20),
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

class ImageContainer extends StatelessWidget {

  ImageContainer({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "img",
      child: GestureDetector(
        onTap: () => Get.toNamed('detail'),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.black,
            image: DecorationImage(
              image: NetworkImage(unsplashController.getUrl()),
              fit: BoxFit.cover
            )
          ),
        ),
      ),
    );
  }
}

Future<void> _showNotification() async {

  const AndroidNotificationDetails androidPlatformChannelSpecifics = 
    AndroidNotificationDetails(
      'channelId', 'channelName', 'channelDescription',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker'
    );
  const NotificationDetails platformChannelSpecifics = 
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0, 'IPHY', 'Tienes: ${databaseController.count} pendientes', platformChannelSpecifics, payload: 'item'
    );
}

