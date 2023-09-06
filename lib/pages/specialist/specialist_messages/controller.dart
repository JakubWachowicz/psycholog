import 'dart:convert';

import 'package:get/get.dart';
import 'package:jw_projekt/common/routes/routes.dart';
import 'package:jw_projekt/common/stores/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jw_projekt/controller/db_data_controller.dart';
import 'package:jw_projekt/pages/specialist/specialist_messages/widgets/sort_button.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:firebase_auth/firebase_auth.dart' as authP;
import 'package:flutter/material.dart';
import '../../../controller/send_message_controller.dart';
import '../../../entities/messages.dart';
import '../../../entities/msg_content.dart';
import '../../../entities/user.dart';
import 'index.dart';
import 'dart:async';

class SpecialistMessagesConroller extends GetxController {
  SpecialistMessagesConroller();

  final SpecialistMessagesState state = SpecialistMessagesState();
  final db = FirebaseFirestore.instance;
  final token = UserStore.to.token;
  var listener;
  DbDataController db_controller = DbDataController();


  final TextEditingController searchController = TextEditingController();
  String searchKeyword = '';



  final RefreshController refreshController = RefreshController(
    initialRefresh: true,
  );


  String? getCurrentUserId() {
    authP.FirebaseAuth auth = authP.FirebaseAuth.instance;
    String? currentUser = auth.currentUser?.uid;
    return currentUser;
  }

  void searchMessages(String keyword) {


    print('Testowanie');
    print(searchController.text);
    // Update the search keyword and perform the search
    state.filteredMessages.clear();
    state.filteredMessages.assignAll(filterMessages(state.messages, searchController.text));

  }

  List<Msg> filterMessages(List<Msg> messages, String searchText) {

    return messages.where((message) => message.student_name!.contains(searchText)).toList();
  }

  void updateFilterList(){
    state.filteredMessages.clear();
    state.filteredMessages.assignAll(state.messages.value);
    filterMessages(state.messages, searchController.text);

  }


  Future<UserData?> fetchCurrentUser() async {
    var userSnapshot = await db
        .collection("users")
        .withConverter(
          fromFirestore: UserData.fromFirestore,
          toFirestore: (UserData userData, options) => userData.toFirestore(),
        )
        .where("id", isEqualTo: getCurrentUserId())
        .get();

    if (userSnapshot.docs.isNotEmpty) {
      return userSnapshot.docs[0].data();
    }

    return null;
  }


  DbDataController dbDataController = DbDataController();


  goChat(UserData to_userdata) async {




    UserData? data = await fetchCurrentUser()!;
    print(to_userdata);

    dbDataController.goChat(data!,to_userdata!,false);



  }

  late final name;
  static const oneSecond = const Duration(seconds: 25);
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    UserData? data = await fetchCurrentUser();
    name = data?.name;

    initAsyncChatRefresh();
    //TO jest chyba dosyć nie optymalne
    //TODO: Update tylko czasu a nie wszystkieoo
    new Timer.periodic(oneSecond, (Timer t)  {state.messages.refresh();
    print("Update");});
  }


  Future<int> getUnreadMessageCount(String docId) async {
    var from_messages = await db
        .collection("messages")
        .doc(docId)
        .collection("msglist")
        .withConverter(
            fromFirestore: Msgcontent.fromFirestore,
            toFirestore: (Msgcontent msg, options) => msg.toFirestore())
        .where("uid", isNotEqualTo: token)
        .where("isRead", isEqualTo: "False")
        .get();

    return from_messages.docs.length;
  }

  void sortMessages(SortType sortType) {
    print("rozpoczęto sortowanie");
    print(sortType);
    switch (sortType) {
      case SortType.timestamp:
        state.messages.sort((a, b) {
          final aTime = a.last_time;
          final bTime = b.last_time;
          return bTime!.compareTo(aTime!);
        });
        updateFilterList();
        print('Posortowano po dacie');
        break;
      case SortType.alphabetical:
        state.messages.sort((a, b) {
          final aTime = a.student_name;
          final bTime = b.student_name;
          return aTime!.compareTo(bTime!);
        });
        updateFilterList();
        print("Posortowano po nazwie");
        break;
    }

  }





  void initAsyncChatRefresh() async{

    var data = await db
        .collection("messages")
        .withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg, options) => msg.toFirestore()).where("specialist_uid",isEqualTo:token);

    state.messages.clear();

    listener = data.snapshots().listen(
          (event) async {
        for (var change in event.docChanges) {
          switch (change.type) {
            case DocumentChangeType.added:
              if (change.doc.data() != null) {
                state.messages.insert((0), change.doc.data()!);
                print('dodano');
                updateFilterList();

              }
              break;
            case DocumentChangeType.modified:
              var modifiedMessage = change.doc.data();
              if (modifiedMessage != null) {
                // Find the index of the modified message in the list
                print("Tutaj coś nie gra lol");
                var index = state.messages.indexWhere((msg) => msg.messageId == modifiedMessage.messageId);
                print(index);
                print("Tutaj coś nie gra popop");
                if (index != -1) {
                  // Replace the old message with the modified message
                  state.messages[index] = modifiedMessage;
                  print(state.messages[index].last_msg);

                  state.messages.sort((a, b) {
                    final aTime = a.last_time;

                    final bTime = b.last_time;

                    return bTime!.compareTo(aTime!);
                  });
                  state.messages.refresh();
                  updateFilterList();






                }}
              break;
            case DocumentChangeType.removed:
              break;
          }
        }
      },
      onError: (error) => print("listen failed: ${error}"),
    );

    state.messages.sort((a, b) {
      final aTime = a.last_time;
      final bTime = b.last_time;
      return bTime!.compareTo(aTime!);
    });
    updateFilterList();




  }




}
