import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jw_projekt/entities/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as authP;

class DbDataController{

  final db = FirebaseFirestore.instance;

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

  String? getUser(){
    UserData user = fetchCurrentUser() as UserData;

    return user.role;
  }

  String? getCurrentUserId() {
    authP.FirebaseAuth auth = authP.FirebaseAuth.instance;
    String? currentUser = auth.currentUser?.uid;
    return currentUser;
  }

}