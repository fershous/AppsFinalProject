
import 'package:final_project/auth/login_page.dart';
import 'package:flutter/material.dart';

import 'dart:async';

import 'package:get/get.dart';

class ExitSplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    Timer(Duration(seconds: 1), () {
      Get.off(() => LoginPage(), duration: Duration(milliseconds: 500));
    });

    return Material(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: size.height * 0.25,
          ),
          Image.asset(
            'assets/Logo IPHY White.png',
            height: size.height * 0.30,
          ),
          SizedBox(height: 120),
          Text('IPHY', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 64),),
          RichText(
            text: TextSpan(
              text: 'by ', style: TextStyle(color: Colors.white),
              children: [
                TextSpan(text: 'Fer, Elias, Francisco', style: TextStyle(fontWeight: FontWeight.bold))
              ]
            )
          ),
          Spacer(),
          Text('ver 1.0', style: TextStyle(color: Colors.grey[350]),)
        ],
      ),
    );
  }
}
