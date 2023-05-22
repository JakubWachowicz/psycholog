
import 'package:get/get.dart';
import 'package:jw_projekt/pages/admin/create_account/student_form/index.dart';


import '../../signin/controller.dart';
import 'controller.dart';

class CreateAccountBinding implements Bindings{

  @override
  void dependencies() {
    Get.lazyPut<CreateAccountConroller>(()=> CreateAccountConroller());
    Get.lazyPut<StudentFormConroller>(()=> StudentFormConroller());


  }

}