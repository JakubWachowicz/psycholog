


import 'package:cloud_firestore/cloud_firestore.dart';

import '../entities/reportComment.dart';

class ReportDbController {

  Future<void> sendComment(String reportId, String content, String uid) async {
    try {
      // Create a reference to the Firestore collection containing the reports
      CollectionReference reportsCollection =
      FirebaseFirestore.instance.collection('reports');

      // Create a reference to the specific report document using its ID
      DocumentReference reportDoc = reportsCollection.doc(reportId);

      // Create a new comment document with the provided content and UID
      DocumentReference commentDoc = await reportDoc.collection('comments').add({
        'content': content,
        'uid': uid,
        'reportId': reportId,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Optionally, you can update the report document with the comment information
      await reportDoc.update({
        'lastComment': commentDoc.id,
        'commentCount': FieldValue.increment(1),
      });

      // Comment sent successfully
      print('Comment sent to database');
    } catch (e) {
      // An error occurred while sending the comment
      print('Error sending comment: $e');
    }
  }



  final db = FirebaseFirestore.instance;
  Query<ReportComment>fetchComments(String reportId)  {
    var data =  db
        .collection("reports")
        .doc(reportId).collection("comments")
        .withConverter(
        fromFirestore: ReportComment.fromFirestore,
        toFirestore: (ReportComment reportComment, options) => reportComment.toFirestore());

    return data;
  }


}
