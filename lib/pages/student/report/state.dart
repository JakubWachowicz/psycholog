import 'package:get/get.dart';
class ReportState{

  Rx<String> currentRole ="student".obs;
  set setRole(value) => currentRole.value = value;

  final List<String> roles = <String>["student","specialist","admin"];

  var index = 0.obs;

}