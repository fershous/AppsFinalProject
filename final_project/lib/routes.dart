import 'package:get/route_manager.dart';

import 'pages/home.dart';
import 'pages/detail_page.dart';
import 'package:final_project/auth/login_page.dart';

routes() => [
  GetPage(name: "home", page: () => HomePage()),
  GetPage(name: "/", page: () => LoginPage()),
  GetPage(name: "detail", page: () => DetailPage()),
];