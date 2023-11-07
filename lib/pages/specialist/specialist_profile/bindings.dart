
import 'package:get/get.dart';
import '../../../controller/profile_data_controller.dart';
import 'controller.dart';
class SpecialistProfileBinding implements Bindings{

  @override
  void dependencies() {
    Get.lazyPut<SpecialistProfileConroller>(()=> SpecialistProfileConroller());
    Get.lazyPut<ProfileDataController>(()=> ProfileDataController());
  }
}