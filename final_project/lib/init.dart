
import 'package:final_project/dialogs/task_dialog.dart';
import 'package:get/get.dart';
import 'package:unsplash_client/unsplash_client.dart';

import 'package:final_project/controllers/database_controller.dart';
import 'package:final_project/controllers/unsplash_controller.dart';

class Init {

  static Future initialize() async {
    await _registerServices();
    await _loadSettings();
  }

  static _registerServices() async {

    final unsplashController = Get.find<UnsplashController>();

    final client = UnsplashClient(
      settings: ClientSettings(
        credentials: AppCredentials(
          accessKey: 'sgREAtZ1Njqlw7w-9oQhK5NrMhBBJ1S84JzBe6dl8S0',
          secretKey: 'Nu9aqUEnDWY43Th51-VaPLVg42ul_4sJZk0xUG28tfs'
        )
      )
    );

    final photo = await client.photos.random(
      collections: ['34294057'],
      count: 1,
    ).goAndGet();

    unsplashController.saveUrl(photo[0].urls.small.toString());

    client.close();
  
  }

  static _loadSettings() async {
    await Future.delayed(Duration(seconds: 5));
    final dataBaseController = Get.find<DatabaseController>();
    print("Starting loading services");
    await dataBaseController.database;
    databaseController.queryAll();
    print("Finished loading services");

  }

}