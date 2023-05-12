import 'package:cloud_firestore/cloud_firestore.dart';


class SpecialistData {
  final String? id;
  final String? description;
  final String? role;

  SpecialistData({
    this.id,
    this.description,


    this.role,
  });

  factory SpecialistData.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return SpecialistData(
      id: data?['id'],
      description: data?['description'],
      role: data?['role'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if(role != null) "role" :role,
      if(description!=null) "description":description,
    };
  }
}
