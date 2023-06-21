import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jw_projekt/common/stores/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  RxList<DraggableList> allLists = [
    DraggableList(header: 'TODO', items: [
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
    DraggableList(header: 'IN PROGRESS', items: [
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
  void onReady() {
    super.onReady();
  }

  late final name;
  late final topName;

  @override
  void onInit() {
    super.onInit();
    lists = allLists.map(buildList).toList().obs;
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
