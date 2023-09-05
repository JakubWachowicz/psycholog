import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jw_projekt/entities/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as authP;
class UserInfoController{

  final db = FirebaseFirestore.instance;

  UserInfoController._();
  static final instance =  UserInfoController._();
  late UserData userData;



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
      userData = userSnapshot.docs[0].data();
      return userSnapshot.docs[0].data();
    }

    return null;
  }


  String? getCurrentUserId() {
    authP.FirebaseAuth auth = authP.FirebaseAuth.instance;
    String? currentUser = auth.currentUser?.uid;
    print(currentUser);
    return currentUser;
  }


}