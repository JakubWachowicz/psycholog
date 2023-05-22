import 'package:get/get.dart';

import '../../signin/controller.dart';
import '../create_account/index.dart';
import '../create_account/student_form/index.dart';
import 'controller.dart';

class AdminSettingsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminSettingsController>(() => AdminSettingsController());

  }
}
