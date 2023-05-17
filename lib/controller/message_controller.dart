import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:jw_projekt/Utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jw_projekt/pages/messages/index.dart';

import '../common/stores/user.dart';
import '../entities/user.dart';


class MessageController extends GetxController{



  final db = FirebaseFirestore.instance;
  final token = FirebaseAuth.instance.currentUser!.uid;
  final MessagesState state= MessagesState();

  @override
  void onReady(){
    super.onReady();
    loadMessages();
  }

  Future<void>sendMessage(String receiverId,String text,String chatId)async {


  }



  Future<void>loadMessages()async {

    var userbase = await db.collection("users").where("id",isNotEqualTo: token).withConverter(fromFirestore: UserData.fromFirestore, toFirestore: (UserData userdata,options) =>userdata.toFirestore()).get();

    for(var doc in userbase.docs){
      //state.messageList.add(doc.data());
    }


  }




}