import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:final_project/controllers/unsplash_controller.dart';

final unsplashController = Get.find<UnsplashController>();

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(46, 197, 206, 1.0),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          AppBar(),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return TaskWidget();
              },
              childCount: 10,
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

class AppBar extends StatelessWidget {
  const AppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.transparent,
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text('Equis de', style: TextStyle(color: Colors.black),),
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