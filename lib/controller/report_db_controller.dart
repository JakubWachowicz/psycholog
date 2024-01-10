import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jw_projekt/entities/msg_content.dart';
import 'package:jw_projekt/entities/user.dart';

import '../common/routes/routes.dart';
import '../entities/messages.dart';
import '../entities/report.dart';
import '../entities/reportComment.dart';
import 'package:get/get.dart';

class ReportDbController {

  Stream<QueryDocumentSnapshot<Report>> fetchReportWithListener(String reportId) {
    // Create a stream controller to handle the stream of report snapshots
    StreamController<QueryDocumentSnapshot<Report>> controller =
    StreamController<QueryDocumentSnapshot<Report>>();

    // Fetch the initial report snapshot
    db
        .collection("reports")
        .withConverter(
      fromFirestore: Report.fromFirestore,
      toFirestore: (Report report, options) => report.toFirestore(),
    )
        .where("reportId", isEqualTo: reportId)
        .snapshots()
        .listen((snapshot) {
      print(snapshot.docs.length);
      if (snapshot.docs.isNotEmpty) {
        // Add the first report snapshot to the stream
        controller.add(snapshot.docs.first);
      }
    });

    // Return the stream from the controller
    return controller.stream;
  }


  Future<void> sendComment(
      String reportId, String content, String uid, String username) async {
    try {
      // Create a reference to the Firestore collection containing the reports
      CollectionReference reportsCollection =
          FirebaseFirestore.instance.collection('reports');

      // Create a reference to the specific report document using its ID
      DocumentReference reportDoc = reportsCollection.doc(reportId);

      // Create a new comment document with the provided content and UID
      DocumentReference commentDoc =
          await reportDoc.collection('comments').add({
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
  }void goToReportChat(
      String reportId,
      UserData studentData,
      UserData specialistData,
      bool isStudent,
      String report_title,
      ) async {
    try {
      // Fetch the report document using the provided DocumentReference
      CollectionReference reportsCollection =
      FirebaseFirestore.instance.collection('reports');

      // Create a reference to the specific report document using its ID
      DocumentReference reportDoc = reportsCollection.doc(reportId);


        // Check if the "messages" subcollection is empty
        var messagesQuery = await reportDoc.collection("messages").get();

        if (messagesQuery.docs.isEmpty) {
          // "messages" subcollection is empty, add a new message
          var msgdata = Msg(
            student_uid: studentData.id!,
            specialist_uid: specialistData.id!,
            student_name: studentData.name!,
            specialist_name: specialistData.name!,
            student_avatar: studentData.photourl,
            specialist_avatar: specialistData.photourl,
            last_msg: "",
            last_time: Timestamp.now(),
            msg_num: 0,
          );

          // Update the messages subcollection within the report document
          await reportDoc.collection("messages").withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore(),
          ).add(msgdata);
        }

        // Now proceed with navigation
        Get.toNamed(AppRoutes.SpecialistReportChat, parameters: {
          "report_id": reportDoc.id, // Use the document ID directly
          "student_uid": studentData.id ?? "error",
          "specialist_uid": specialistData.id ?? "errorName",
          "report_title": report_title ?? "error",
          // Add more parameters as needed
        });
      }
    catch (e) {
      // Handle any errors
      print("Error fetching report document: $e");
    }
  }

  Query<Msgcontent> fetchChatMessages(String reportId) {
    var data = db
        .collection("reports")
        .doc(reportId)
        .collection("messages")
        .withConverter(
            fromFirestore: Msgcontent.fromFirestore,
            toFirestore: (Msgcontent reportComment, options) =>
                reportComment.toFirestore())
        .orderBy("timestamp", descending: false);

    return data;
  }

  final db = FirebaseFirestore.instance;

  Query<ReportComment> fetchComments(String reportId) {
    var data = db
        .collection("reports")
        .doc(reportId)
        .collection("comments")
        .withConverter(
            fromFirestore: ReportComment.fromFirestore,
            toFirestore: (ReportComment reportComment, options) =>
                reportComment.toFirestore())
        .orderBy("timestamp", descending: false);

    return data;
  }

  fetchAllReports() {
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
    final reportsCollection = firestore
        .collection('reports'); // Replace with your Firestore collection name

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
      return null; // You might want to handle this differently
    }
  }
}
