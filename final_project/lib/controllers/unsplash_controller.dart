import 'package:get/get.dart';

class UnsplashController extends GetxController {

  var image;
  String photoUrl = '';

  saveUrl(String url) {
    photoUrl = url;
  }

  String getUrl() {
    return photoUrl;
  }

}