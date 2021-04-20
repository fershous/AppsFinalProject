
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

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10), 
        child: BodyWidget()
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
    );
  }
}

class BodyWidget extends StatelessWidget {
  const BodyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Container(
        margin: EdgeInsets.all(7),
        child: Column(
          children: <Widget>[
            Column(
              children: [
                HeaderWidget(),
                SizedBox( height: 10 ),
                ImageContainer(),
              ],
            ),
          ]
        ),
      ),
    );
  }
  
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
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
        ),
        Spacer(),
        Icon(Icons.notifications_outlined)
      ]
    );
  }
}

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "nav",
      child: Container(
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
    );
  }
}