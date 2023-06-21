import 'package:flutter/material.dart';
import 'package:jw_projekt/common/services/storage.dart';
import 'package:jw_projekt/common/stores/config.dart';
import 'package:jw_projekt/common/stores/user.dart';
import 'package:jw_projekt/pages/welcome/controller.dart';


import 'Utils/constants.dart';


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'common/routes/pages.dart';
import 'controller/auth_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'controller/profile_data_controller.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync<StorageService>(() => StorageService().init());
  Get.put<ConfigStore>(ConfigStore());
  Get.put(WelcomeController());

  Get.put<UserStore>(UserStore());
  await Firebase.initializeApp().then((value) {
    Get.put(AuthenticationClontroller());
  });
  ProfileDataController.initialize();
  ProfileDataController.initProfile();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return  ScreenUtilInit(builder: (BuildContext context, Widget? child) =>

        GetMaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: Colors.white,
          ),
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
        )
      ,);
  }
}

