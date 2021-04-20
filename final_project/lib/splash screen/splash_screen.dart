
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Material(
      child: Stack(
        children: <Widget>[
          Container(
            color: Colors.black,
            height: size.height
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
