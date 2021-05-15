
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

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
