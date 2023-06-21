import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jw_projekt/entities/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as authP;

import 'package:firebase_database/firebase_database.dart';

class DbDataController{

  final db = FirebaseFirestore.instance;

  Future<UserData?> fetchCurrentUser()  async {
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







  final  _database = FirebaseDatabase.instance;





  Future<void> updateData(String key, dynamic value) async {
    var collection = FirebaseFirestore.instance.collection('users').where('id',isEqualTo: getCurrentUserId());
    print(collection.get());
    var querySnapshots = await collection.get();
    for (var doc in querySnapshots.docs) {
      print(doc);
      await doc.reference.update({
        key:value
      });
    }

  }



  String? getUser(){
    UserData user = fetchCurrentUser() as UserData;

    return user.role;
  }

  Future<String?> getName() async {
    var user = await fetchCurrentUser();

    return user?.name;
  }

  Future<String?> getAvatar(id) async {



    var userSnapshot = await db
        .collection("users")
        .withConverter(
      fromFirestore: UserData.fromFirestore,
      toFirestore: (UserData userData, options) => userData.toFirestore(),
    )
        .where("id", isEqualTo: id)
        .get();
    if (userSnapshot.docs.isNotEmpty) {
      var user =  userSnapshot.docs[0].data();
      return user.photourl;
    }
    return 'assets/logo.png';
  }






  UserData getUSerData(){
    UserData user = fetchCurrentUser() as UserData;

    return user;
  }

  Future<String> getPhoto() async {
    var user = await fetchCurrentUser();
    return user!.photourl??"assets/logo.jpg";

  }



  String? getCurrentUserId() {
    authP.FirebaseAuth auth = authP.FirebaseAuth.instance;
    String? currentUser = auth.currentUser?.uid;
    print(currentUser);
    return currentUser;
  }

}