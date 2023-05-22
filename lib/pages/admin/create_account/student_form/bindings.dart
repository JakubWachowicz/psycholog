
import 'package:get/get.dart';



import 'controller.dart';

class StudentFormBinding implements Bindings{

  @override
  void dependencies() {
    Get.lazyPut<StudentFormConroller>(()=> StudentFormConroller());


  }

}