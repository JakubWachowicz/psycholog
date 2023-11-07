


import 'package:cloud_firestore/cloud_firestore.dart';

import '../entities/report.dart';
import '../entities/reportComment.dart';

class ReportDbController {

  Future<void> sendComment(String reportId, String content, String uid,String username) async {
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
        'userName': username,
        'reportId': reportId,
        'timestamp': Timestamp.now(),
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
        toFirestore: (ReportComment reportComment, options) => reportComment.toFirestore()).orderBy("timestamp", descending: false);

    return data;
  }


  fetchAllReports(){
    var reports = db
        .collection("reports")
        .withConverter(
        fromFirestore: Report.fromFirestore,
        toFirestore: (Report report, options) => report.toFirestore())
        .orderBy("timestamp", descending: false);

    return reports;
  }




  Future<Map<String, List<Report>>?> fetchReportsByStatus() async {
    final firestore = FirebaseFirestore.instance;
    final reportsCollection = firestore.collection('reports'); // Replace with your Firestore collection name

    final notAssignedReports = <Report>[];
    final inProgressReports = <Report>[];
    final doneReports = <Report>[];

    try {
      final querySnapshot = await reportsCollection.get();
      querySnapshot.docs.forEach((doc) {
        final report = Report.fromFirestore(doc, null);

        // Categorize reports based on status
        switch (report.status) {
          case 'not assign':
            notAssignedReports.add(report);
            break;
          case 'in progress':
            inProgressReports.add(report);
            break;
          case 'done':
            doneReports.add(report);
            break;
        }
      });

      // Create a map to store the categorized reports
      final reportsMap = {
        'notAssign': notAssignedReports,
        'inProgress': inProgressReports,
        'done': doneReports,
      };

      return reportsMap;
    } catch (e) {
      // Handle any errors (e.g., Firestore read error)
      print('Error fetching reports: $e');
      return null;// You might want to handle this differently
    }
  }







}
