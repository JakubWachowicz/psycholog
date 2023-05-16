import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  final String? title;
  final String? content;
  final String? status;
  final String? studentId;
  final String? caretaker;
  final String? priority;
  final String? reportType;
  final Timestamp? timestamp;

  Report({
    this.title,
    this.content,
    this.status,
    this.studentId,
    this.caretaker,
    this.priority,
    this.reportType,
    this.timestamp,
  });

  factory Report.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Report(
      title: data?['title'],
      content: data?['content'],
      status: data?['status'],
      studentId: data?['studentId'],
      caretaker: data?['caretaker'],
      priority: data?['priority'],
      reportType: data?['reportType'],
      timestamp: data?['timestamp'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (status != null) 'status': status,
      if (studentId != null) 'studentId': studentId,
      if (caretaker != null) 'caretaker': caretaker,
      if (priority != null) 'priority': priority,
      if (reportType != null) 'reportType': reportType,
      if (timestamp != null) 'timestamp': timestamp,
    };
  }
}
