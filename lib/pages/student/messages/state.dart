import 'package:get/get.dart';


import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../entities/messages.dart';
class MessagesState{

  var count = 0.obs;
  //RxList<UserData> messageList = <UserData>[].obs;
  RxList<QueryDocumentSnapshot<Msg>> messageList = <QueryDocumentSnapshot<Msg>>[].obs;
  var unreadMsgCounter = RxMap();

  var messageLimit = 2.obs;

}