import 'package:flutter/material.dart';

class TasksDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: Text('Equis de x2'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Algo'),
            Text('Algo x2')
          ]
        )
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Approve'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );

  }
}