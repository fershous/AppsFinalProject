
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateTimeController extends GetxController {

  final DateTime _now = DateTime.now();
  final DateFormat _formatter = DateFormat('dd-MM-yyyy');
  final DateFormat _timeFormatter = DateFormat('Hm');

  RxString date = ''.obs;
  RxString time = ''.obs;

  void getDate() {
    date.value = _formatter.format(_now); 
    time.value = _timeFormatter.format(_now); 
  }

  void setDateTime(DateTime dateTime) {
    date.value = _formatter.format(dateTime);
    time.value = _timeFormatter.format(dateTime);
  }

}