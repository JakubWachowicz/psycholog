import 'package:get/get.dart';

import '../../entities/messages.dart';
import '../../entities/specialist.dart';
import '../../entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ContactState{

  var count = 0.obs;
  RxList<UserData> messageList = <UserData>[].obs;
  RxList<SpecialistData> specialistList = <SpecialistData>[].obs;


}