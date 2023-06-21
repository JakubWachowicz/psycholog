import '../../entities/report.dart';

class DraggableList {
  final String header;
  final List<Report> items;

   DraggableList({required this.header, required this.items});
}

class DraggableListItem {
  final String title;
  final String reportContent;
  final String timeStamp;
  final String caretaker;
  final String priority;
  final String status;

   DraggableListItem(this.reportContent, this.timeStamp, this.caretaker,
      this.priority, this.status,
      {required this.title});
}

