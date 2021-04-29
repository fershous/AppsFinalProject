
import 'package:final_project/dialogs/task_dialog.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

import 'package:final_project/controllers/unsplash_controller.dart';


final unsplashController = Get.find<UnsplashController>();

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ShapeBorder? bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(25)),
  );
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;
  EdgeInsets padding = const EdgeInsets.all(12);
  int _selectedItemPosition = 2;
  SnakeShape snakeShape = SnakeShape.circle;
  Color selectedColor = Colors.white;

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
            Icon(Icons.notifications_none, color: Colors.black,)
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
        bottomNavigationBar: SnakeNavigationBar.color(
          behaviour: SnakeBarBehaviour.floating,
          snakeShape: SnakeShape.circle,
          shape: bottomBarShape,
          padding: EdgeInsets.all(12),
          backgroundColor: Colors.black,

          snakeViewColor: selectedColor,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,

          showUnselectedLabels: false,
          showSelectedLabels: false,

          currentIndex: _selectedItemPosition,
          onTap: (index) => setState(() => _selectedItemPosition = index),
          items: [
            const BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'tickets'),
            const BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'calendar'),
            const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
            const BottomNavigationBarItem(icon: Icon(Icons.unsubscribe_rounded), label: 'email'),
            const BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search'),
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

    return SafeArea(
      child: Column(
        children: [
          SizedBox( height: 10 ),
          ImageContainer(),
          SizedBox(height: 20,),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return TaskWidget();
              }
            ),
          )
        ],
      ),
    );
  }
  
}

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      child: TaskContent(),
    );
  }
}

class TaskContent extends StatelessWidget {
  const TaskContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          Text('Exámen de redes', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24)),
          SizedBox(height: 5),
          Row(
            children: <Widget>[
              Text('Hoy 13:00'),
              Spacer(),
              Text('Microsoft Teams', style: TextStyle(fontWeight: FontWeight.bold),)
            ],
          )
        ]
      )
    );
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
        Text('HDTPM', style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 30.0
        ),),
      ],
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