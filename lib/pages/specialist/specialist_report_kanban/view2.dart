import 'package:flutter/cupertino.dart';
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
import 'package:scroll_snap_list/scroll_snap_list.dart';
class SpecialistReportKanbanPageOld extends StatefulWidget {
   SpecialistReportKanbanPageOld({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;




  @override
  State<SpecialistReportKanbanPageOld> createState() => _SpecialistReportKanbanPage();
}

class _SpecialistReportKanbanPage extends State<SpecialistReportKanbanPageOld> {
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

    buildList(reportList){
      return Container(

        width: 30.sw,
        decoration:  BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Container(

              width: double.infinity,
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5)
                )
              ),
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(10.0,),
                child: Text("Head",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white,fontSize: 22),),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                Card(child:Text("LOL")),
                Card(child:Text("LOL")),

              ],),
            )
          ],
        ),
      );
    }



    Widget buildList2(DraggableList list) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(

          color: CupertinoColors.extraLightBackgroundGray,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(7.0)),
                    color: Colors.green,
                  ),
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  child: Text(
                    'Header ${list.header}',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: list.items.length,
                  itemBuilder: (context, index) {
                    return ReportItem(list.items[index]);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }



    int _index = 0;
    buildTrello(){
      return  PageView.builder(
        itemCount: 3,
        controller: PageController(viewportFraction: 0.8),
        onPageChanged: (index) => setState(() => _index = index),
        itemBuilder: (context, index) {
          return AnimatedPadding(
            duration: const Duration(milliseconds: 400),
            curve: Curves.fastOutSlowIn,
            padding: const EdgeInsets.all( 8.0),
            child: buildList2(allLists[_index])
          );
        },
      );
    }
    return Scaffold(
      appBar: _buildAppBar(),
      body:buildTrello()
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          alignment: Alignment.topLeft,
          decoration: BoxDecoration(
            color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
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
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //Text("Priority: " +  report.priority.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(height: 10.w,),


                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }



}



