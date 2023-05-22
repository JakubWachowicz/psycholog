import 'package:get/get.dart';
class CreateAccountState{

  Rx<String> currentRole ="student".obs;
  set setRole(value) => currentRole.value = value;

  final _formTypePage = 0.obs;
  int get formTypePage => _formTypePage.value;
  set formTypePage(value) => _formTypePage.value = value;


}