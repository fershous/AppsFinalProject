import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: BodyWidget()
      ),
    );
  }
}

class BodyWidget extends StatelessWidget {
  const BodyWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('Hi, Pendejo')
            ]
          ),
          
        ]
      ),
    );
  }
}
