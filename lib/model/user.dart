import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? firstName;
  String? lastName;
  String? email;
  String? uid;
  String? pesel;
  String? accesToken;

  User({
    this.firstName,
    this.lastName,
    this.email = "not assigned",
    this.uid,
    this.pesel,
    this.accesToken,
  });

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email ?? "not assigned",
        "uid": uid,
        "pesel": pesel,
        "accesToken": accesToken ?? "-"
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      firstName: snapshot['firstName'],
      lastName: snapshot['lastName'],
      email: snapshot['email'],
      uid: snapshot['uid'],
      pesel: snapshot['pesel'],
      accesToken: snapshot['accesToken']
    );
  }
}
