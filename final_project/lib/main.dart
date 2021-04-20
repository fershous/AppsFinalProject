import 'package:final_project/controllers/unsplash_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:final_project/init.dart';
import 'package:final_project/routes.dart';
 
import 'package:final_project/splash%20screen/splash_screen.dart';
import 'package:final_project/splash%20screen/exit_splash_screen.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  
  final UnsplashController unsplashController = Get.put(UnsplashController());

  final Future _initFuture = Init.initialize();

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'La App Esta',
      home: FutureBuilder(
        future: _initFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if (snapshot.connectionState == ConnectionState.done)
            return ExitSplashScreen();
          else
            return SplashScreen();
        },
      ),
      initialRoute: '/',
      getPages: routes(),
    );
  }
}