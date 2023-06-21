import 'package:flutter/material.dart';
import 'package:jw_projekt/entities/report.dart';
import 'package:kanban_board/custom/board.dart';
import 'package:kanban_board/models/inputs.dart';
import 'package:get/get.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import '../../../Utils/date.dart';
import '../../../Widgets/nav_bar.dart';

import '../../../Widgets/specialist/draggable_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../common/routes/routes.dart';
import 'controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class SpecialistReportKanbanPage extends StatefulWidget {
   SpecialistReportKanbanPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;




  @override
  State<SpecialistReportKanbanPage> createState() => _SpecialistReportKanbanPage();
}

class _SpecialistReportKanbanPage extends State<SpecialistReportKanbanPage> {
  int _counter = 0;
  late List<DragAndDropList> lists;

  void openItemDetailsPage(String item) {
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: ModalRoute.of(context)!.animation!,
                curve: Curves.easeOut,
              ),
            ),
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.close, color: Colors.green),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              backgroundColor: Colors.white,
              body: Center(
                child: Text(
                  item,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }





  RxList<DraggableList> allLists = [
    DraggableList(header: 'To do', items: [
      Report(
        reportId: 'R123',
        title: 'Example Report',
        content: 'This is an example report',
        status: 'Pending',
        studentId: 'S456',
        caretaker: 'John Doe',
        priority: 'High',
        reportType: 'General',
        timestamp: Timestamp.now(),
      )
    ]),
    DraggableList(header: 'In progress', items: [
      Report(
        reportId: 'R123',
        title: 'Example Report',
        content: 'This is an example report',
        status: 'Pending',
        studentId: 'S456',
        caretaker: 'John Doe',
        priority: 'High',
        reportType: 'General',
        timestamp: Timestamp.now(),
      )
    ]),

    DraggableList(header: 'Done', items: [
      Report(
        reportId: 'R123',
        title: 'Example Report',
        content: 'This is an example report',
        status: 'Pending',
        studentId: 'S456',
        caretaker: 'John Doe',
        priority: 'High',
        reportType: 'General',
        timestamp: Timestamp.now(),
      )
    ]),

  ].obs;





  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lists = allLists.map(buildList).toList();
  }

  @override
  Widget build(BuildContext context) {




    AppBar _buildAppBar(){
      return AppBar(
        title: Text("Trello"),
        backgroundColor: Colors.green,
        actions: [

        ],
      );
    }


    return Scaffold(
      appBar: _buildAppBar(),
      body: DragAndDropLists(
        children: lists,
        onItemReorder: onReorderListItem,
        onListReorder: (int oldListIndex, int newListIndex) {  },
        axis: Axis.horizontal,
        listWidth: 350,
        listDraggingWidth: 150,
        listDecoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: const BorderRadius.all(Radius.circular(7.0)),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.black45,
              spreadRadius: 3.0,
              blurRadius: 6.0,
              offset: Offset(2, 3),
            ),
          ],
        ),
        listPadding: const EdgeInsets.all(8.0),
      ),
    );
  }

  void onReorderListItem(
      int oldItemIndex,
      int oldListIndex,
      int newItemIndex,
      int newListIndex,
      ){
    setState(() {
      final oldListItems = lists[oldListIndex].children;
      final newListItems = lists[newListIndex].children;
      final movedItem = oldListItems.removeAt(oldItemIndex);
      newListItems.insert(newItemIndex,movedItem);
    });
  }

  void goReport(Report report){
    print(report.reportId);
    Get.toNamed(AppRoutes.SpecialistReportMenagment,parameters: {
      "reportId": report.reportId!,
    });
  }


  DragAndDropList buildList(DraggableList list) => DragAndDropList(
    header:Row(
      children: <Widget>[
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(7.0)),
              color: Colors.green,
            ),
            padding: const EdgeInsets.all(10),
            child: Text(
              'Header ${list.header}',
              style: TextStyle(color: Colors.white,fontSize: 22),

            ),
          ),
        ),
      ],
    ), children: list.items.map((item) => DragAndDropItem(
      child: Container(
        height: 90.w,
        color: Colors.white70,

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ReportItem(item)
        ),)
  )).toList(),
  );



  Widget ReportItem(Report report) {
    return InkWell(
      onTap: () =>{

      goReport(report)
    },
      child: Container(
        alignment: Alignment.topLeft,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.green),
            borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.only(top: 10.w, left: 15.w, right: 15.w, bottom: 10.w),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  report.reportType ?? "error",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
                ),
                Text(report.title ?? "error",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
                Container(width: 360.w/1.7,
                  child: Text(report.content ?? "error",overflow: TextOverflow.clip,maxLines: 1,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
                ),
              ],
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //Text("Priority: " +  report.priority.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(height: 10.w,),
                    Text(
                      duTimeLineFormat(
                        report.timestamp!.toDate(),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [

                        Text(report.priority == "notAssigned"?"new":report.priority??""),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }



}



