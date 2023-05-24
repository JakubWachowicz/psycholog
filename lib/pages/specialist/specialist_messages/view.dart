import 'package:jw_projekt/pages/specialist/specialist_messages/widgets/sort_button.dart';
import 'package:jw_projekt/pages/student/messages/widgets/messages_list.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'controller.dart';
import 'widgets/messages_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class SpecialistMessagePage extends GetView<SpecialistMessagesConroller> {
  const SpecialistMessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    Widget _buildSortButton(){
      return Container(

          child: SortButton(onPressed: (SortType sortType) {  controller.sortMessages(sortType);},));
    }

    AppBar _buildAppBar(){
      return AppBar(
        title: Text("Messages"),
        backgroundColor: Colors.green,
        actions: [
          Container(

            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: _buildSortButton(),
            ),
          ),
        ],
      );
    }


    print(controller.state.messageList.length);
    return Scaffold(

        appBar: _buildAppBar(),
        body: Column(
          children: [

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SpecialistMessageList(),
              ),
            ),
          ],
        ));
  }
}
