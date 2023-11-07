import 'package:get/get.dart';
import 'package:jw_projekt/pages/login/controller.dart';
import 'package:jw_projekt/pages/settings/controller.dart';

import '../../common/stores/config.dart';
class SettingsBindings implements Bindings{

  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(()=> SettingsController());

  }

}