
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {

  late final User user;

  void setUser(User u) => user = u;

  User get getUser => user;

}