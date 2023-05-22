import 'package:get/get.dart';

import '../../signin/controller.dart';
import '../admin_settings/index.dart';
import '../create_account/index.dart';
import '../create_account/student_form/index.dart';
import 'controller.dart';

class AdminApplicationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminApplicationConroller>(() => AdminApplicationConroller());
    Get.lazyPut<CreateAccountConroller>(() => CreateAccountConroller());
    Get.lazyPut<StudentFormConroller>(() => StudentFormConroller());
    Get.lazyPut<AdminSettingsController>(() => AdminSettingsController());
  }
}
