import 'package:get/route_manager.dart';

import 'pages/home.dart';
import 'pages/detail_page.dart';

routes() => [
  GetPage(name: "/", page: () => HomePage()),
  GetPage(name: "detail", page: () => DetailPage()),
];