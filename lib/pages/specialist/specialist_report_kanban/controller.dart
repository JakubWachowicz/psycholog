import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jw_projekt/common/stores/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jw_projekt/controller/db_data_controller.dart';
import 'package:jw_projekt/pages/specialist/specialist_chat/state.dart';
import 'package:jw_projekt/pages/specialist/specialist_report_kanban/state.dart';
import 'package:jw_projekt/pages/student/chat/state.dart';

import '../../../Widgets/specialist/draggable_list.dart';
import '../../../common/routes/routes.dart';
import '../../../controller/auth_controller.dart';
import '../../../entities/msg_content.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';

import '../../../entities/report.dart';
import '../../../entities/user.dart';

class SpecialistReportKanbanConroller extends GetxController {
  AuthenticationClontroller auth = AuthenticationClontroller();
  final state = SpecialistReportKanbanState();

  SpecialistReportKanbanConroller();

  var doc_id = null;
  final textController = TextEditingController();
  ScrollController msgScrolling = ScrollController();
  FocusNode contentNode = FocusNode();
  final user_id = UserStore.to.token;
  final db = FirebaseFirestore.instance;
  var listener;
  late final sender;

  late RxList<DragAndDropList> lists;

  DbDataController _dbDataController = DbDataController();




  RxList allLists = [].obs;

  @override
  void onReady() {
    super.onReady();
  }

  late final name;
  late final topName;


  Future<String?> getAvatar(String id) async {
    return await _dbDataController.getAvatar(id);
  }

  Future<UserData?> getProfile(String id) async {
    return await _dbDataController.fetchUser(id);
  }




  void goReport(Report report){
    print(report.reportId);
    Get.toNamed(AppRoutes.SpecialistReportMenagment,parameters: {
      "reportId": report.reportId!,
    });
  }


  void onInit() {
    super.onInit();

    var reports = db
        .collection("reports")
        .withConverter(
      fromFirestore: Report.fromFirestore,
      toFirestore: (Report report, options) => report.toFirestore(),
    )
        .orderBy("timestamp", descending: false);

    state.reportList.clear();


    listener = reports.snapshots().listen(
          (event) {
        for (var change in event.docChanges) {
          switch (change.type) {
            case DocumentChangeType.added:
              if (change.doc.data() != null) {
                state.reportList.insert((0), change.doc.data()!);
              }
              break;
            case DocumentChangeType.modified:
              if (change.doc.data() != null) {
                // Find the report in the list and update its priority
                final modifiedReport = change.doc.data()!;
                final index = state.reportList.indexWhere((report) => report.reportId == modifiedReport.reportId);
                if (index != -1) {
                  state.reportList[index] = modifiedReport;
                }
              }
              break;
            case DocumentChangeType.removed:
              break;
          }
          _reorder();
        }

        // Now that we have the updated reportList, build the DraggableList items
        allLists.assignAll(buildDraggableLists(state.reportList));
      },
      onError: (error) => print("listen failed: ${error}"),
    );
    allLists.assignAll(buildDraggableLists(state.reportList));

  }
  final PageController pageController = PageController(viewportFraction: 0.8);

// Function to build DraggableList items from the reportList
  RxList<DraggableList> buildDraggableLists(List<Report> reportList) {
    // Create DraggableList items based on the status or any other criteria
    RxList<DraggableList> lists = [
      DraggableList(header: 'Not assign', items: []),
      DraggableList(header: 'Assign', items: []),
      DraggableList(header: 'In progress', items: []),
      DraggableList(header: 'Done', items: []),
    ].obs;

    for (var report in reportList) {

      print("Ja działam");
      // Add the report to the corresponding DraggableList based on its status
      switch (report.status) {
        case 'not assigned':
          lists[0].items.add(report);
          print("Ja yeppp!1");
          print(report);
          break;
        case 'assigned':
          lists[1].items.add(report);
          break;
        case 'in progress':
          lists[2].items.add(report);
          break;
        case 'done':
          lists[3].items.add(report);
          break;
      // Add more cases if you have additional status categories
      }
    }


    print(lists[0].items);
    return lists;
  }

// Function to update the order of DraggableList items
  void _reorder() {
    allLists.assignAll(buildDraggableLists(state.reportList));
  }
  @override
  void onClose() {
    msgScrolling.dispose();
    listener.cancel();
    super.onClose();
  }

  void onReorderListItem(
    int oldItemIndex,
    int oldListIndex,
    int newItemIndex,
    int newListIndex,
  ) {
    final oldListItems = lists[oldListIndex].children;
    final newListItems = lists[newListIndex].children;
    final movedItem = oldListItems.removeAt(oldItemIndex);
    newListItems.insert(newItemIndex, movedItem);
  }

  DragAndDropList buildList(DraggableList list) => DragAndDropList(
        header: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(7.0)),
                  color: Colors.green,
                ),
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Header ${list.header}',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
            ),
          ],
        ),
        children: list.items
            .map((item) => DragAndDropItem(
                  child: Container(
                    height: 70,
                    color: Colors.white70,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.title!,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          Text(item.priority!),
                        ],
                      ),
                    ),
                  ),
                ))
            .toList(),
      );
}
