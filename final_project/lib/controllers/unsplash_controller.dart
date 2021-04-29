import 'package:get/get.dart';

class UnsplashController extends GetxController {

  var image;
  RxString photoUrl = ''.obs;

  saveUrl(String url) {
    photoUrl.value = url;
  }

  String getUrl() {
    return photoUrl.value.toString();
  }

}