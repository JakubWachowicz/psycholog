import 'package:get/get.dart';

import '../../entities/messages.dart';
import '../../entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class MessagesState{

  var count = 0.obs;
  //RxList<UserData> messageList = <UserData>[].obs;
  RxList<QueryDocumentSnapshot<Msg>> messageList = <QueryDocumentSnapshot<Msg>>[].obs;


}