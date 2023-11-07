import 'package:jw_projekt/common/routes/routes.dart';

import '../entities/msg_content.dart';
import  'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../entities/specialist.dart';

class SpecialistDbController{



  final db = FirebaseFirestore.instance;
  late String docId;
  late  String id;
  SpecialistDbController(String uid)  {
    id = uid;
  }



  Future<void> setDescription(String description) async {



    var userSnapshot = await db
        .collection("specialists")
        .withConverter(
      fromFirestore: SpecialistData.fromFirestore,
      toFirestore: (SpecialistData userData, options) => userData.toFirestore(),
    )
        .where("id", isEqualTo: id)
        .get();

    print('aaaaa');
    if (userSnapshot.docs.isNotEmpty) {
      print('bbbbbbbb');
      var user = userSnapshot.docs[0].id;

      db.collection("specialists").doc(user).update(
        {"description":description}
      );

    }


  }
  Future<String> getDescritpion() async{

      var userSnapshot = await db
          .collection("specialists")
          .withConverter(
        fromFirestore: SpecialistData.fromFirestore,
        toFirestore: (SpecialistData userData, options) => userData.toFirestore(),
      )
          .where("id", isEqualTo: id)
          .get();
      if (userSnapshot.docs.isNotEmpty) {
        var user = userSnapshot.docs[0].data();
        return user.description!;
      }


    return "";
  }

}