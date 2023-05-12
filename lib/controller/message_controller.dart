import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:jw_projekt/Utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jw_projekt/pages/messages/index.dart';

import '../common/stores/user.dart';
import '../entities/user.dart';
import '../model/message.dart';

class MessageController extends GetxController{


  final Rx<List<Message>> _videoList = Rx<List<Message>>([]);
  final db = FirebaseFirestore.instance;
  final token = FirebaseAuth.instance.currentUser!.uid;
  final MessagesState state= MessagesState();

  @override
  void onReady(){
    super.onReady();
    loadMessages();
  }

  Future<void>sendMessage(String receiverId,String text,String chatId)async {
    Message message = Message(chatId: chatId, senderId: firebaseAuth.currentUser!.uid, text: text, receiverId: receiverId, timestamp: DateTime.now());
    await firestore.collection('chats').doc(chatId).collection('messages').add(message.toJson());
  }



  Future<void>loadMessages()async {

    var userbase = await db.collection("users").where("id",isNotEqualTo: token).withConverter(fromFirestore: UserData.fromFirestore, toFirestore: (UserData userdata,options) =>userdata.toFirestore()).get();

    for(var doc in userbase.docs){
      //state.messageList.add(doc.data());
    }


  }




}