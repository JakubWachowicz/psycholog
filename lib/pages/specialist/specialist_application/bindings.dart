
import 'package:get/get.dart';


import '../../signin/controller.dart';
import 'controller.dart';

class SpecialistApplicationBinding implements Bindings{

  @override
  void dependencies() {
    Get.lazyPut<SpecialistApplicationConroller>(()=> SpecialistApplicationConroller());


  }

}