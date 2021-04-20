
import 'package:flutter/material.dart';

import 'dart:async';

import 'package:get/get.dart';
import 'package:final_project/pages/home.dart';

class ExitSplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    Timer(Duration(seconds: 1), () {
      Get.off(() => HomePage(), duration: Duration(milliseconds: 1500));
    });

    return Material(
      child: Stack(
        children: <Widget>[
          Hero(
            tag: "nav",
            child: Container(
              color: Colors.black,
              height: size.height
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Initialization",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
                SizedBox(height: 20),
                CircularProgressIndicator()
              ],
            ),
          ),
        ]
      ),
    );
  }
}
