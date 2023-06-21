import 'package:get/get.dart';


import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../entities/messages.dart';
class SpecialistMessagesState{

  var count = 0.obs;
  //RxList<UserData> messageList = <UserData>[].obs;
  RxList<QueryDocumentSnapshot<Msg>> messageList = <QueryDocumentSnapshot<Msg>>[].obs;

  RxList<Msg> messages = <Msg>[].obs;
  RxList<Msg> filteredMessages = <Msg>[].obs;
  var unreadMsgCounter = RxMap();

  var messageLimit = 2.obs;
  var isFilterOpen = false.obs;

}