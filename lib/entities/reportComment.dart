import 'package:cloud_firestore/cloud_firestore.dart';

class ReportComment {
  final String? commentId;
  final String? reportId;
  final String? content;
  final String? uid;
  final Timestamp? timestamp;

  ReportComment({
    this.commentId,
    this.reportId,
    this.content,
    this.uid,
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
      timestamp: data?['timestamp'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (commentId != null) 'commentId': commentId,
      if (reportId != null) 'reportId': reportId,
      if (content != null) 'content': content,
      if (uid != null) 'uid': uid,
      if (timestamp != null) 'timestamp': timestamp,
    };
  }
}
