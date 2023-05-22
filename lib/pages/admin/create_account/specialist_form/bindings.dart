import 'package:get/get.dart';

import 'controller.dart';

class SpecialistFormBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpecialistFormConroller>(() => SpecialistFormConroller());
  }
}
