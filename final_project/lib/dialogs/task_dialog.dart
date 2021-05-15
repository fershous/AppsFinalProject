import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:final_project/controllers/database_controller.dart';
import 'package:final_project/controllers/datetime_controller.dart';


final dateTimeController = Get.find<DateTimeController>();
final databaseController = Get.find<DatabaseController>();

final TextEditingController titleController = new TextEditingController();
final TextEditingController descriptionController = new TextEditingController();
final TextEditingController placeController = new TextEditingController();
DateTime dateTime = DateTime.now();

class TasksDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    dateTimeController.getDate();

    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Título'
              ),
              validator: (String? value) {
                return (value != null) ? 'Escribe la tarea ese' : null;
              },
            ),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Descripción'
              ),
            ),
            TextFormField(
              controller: placeController,
              decoration: InputDecoration(
                labelText: 'Lugar'
              ),
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: () => {
                DatePicker.showDateTimePicker(context,
                  showTitleActions: true,
                  minTime: DateTime.now(),
                  onConfirm: (date) { 
                    dateTimeController.setDateTime(date);
                    dateTime = date;
                    print(dateTime.microsecondsSinceEpoch);
                  },
                  currentTime: DateTime.now(),
                  locale: LocaleType.es
                )
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Text(dateTimeController.time.value.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)),
                  Obx(() =>  Text(dateTimeController.date.value.toString())),
                ],
              )),
          ]
        )
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => 
                Navigator.of(context).pop(),
          child: Text('Cancelar')
        ),
        TextButton(
          child: Text('Aceptar'),
          onPressed: () {

            if (titleController.value.text != '') {
              Task task = new Task();
              task..id = null
                  ..type = databaseController.tipo.value
                  ..title = titleController.value.text
                  ..description = descriptionController.value.text
                  ..place = placeController.value.text
                  ..date = dateTime.millisecondsSinceEpoch;
              databaseController.insert(task)
              .then((value) => {
                titleController.clear(),
                descriptionController.clear(),
                placeController.clear(),
                Navigator.of(context).pop(),
              });
            }
            
          },
        ),
      ],
    );

  }
}