import 'package:cloud_firestore/cloud_firestore.dart';

class ReportComment {
  final String? commentId;
  final String? reportId;
  final String? content;
  final String? uid;
  final String? userName; // New property
  final Timestamp? timestamp;

  ReportComment({
    this.commentId,
    this.reportId,
    this.content,
    this.uid,
    this.userName, // Initialize the new property
    this.timestamp,
  });

  factory ReportComment.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return ReportComment(
      commentId: snapshot.id,
      reportId: data?['reportId'],
      content: data?['content'],
      uid: data?['uid'],
      userName: data?['userName'], // Assign the new property from the snapshot data
      timestamp: data?['timestamp'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (commentId != null) 'commentId': commentId,
      if (reportId != null) 'reportId': reportId,
      if (content != null) 'content': content,
      if (uid != null) 'uid': uid,
      if (userName != null) 'userName': userName, // Include the new property
      if (timestamp != null) 'timestamp': timestamp,
    };
  }
}
