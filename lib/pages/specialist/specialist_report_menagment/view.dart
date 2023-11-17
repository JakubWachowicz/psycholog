import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:jw_projekt/Widgets/menu_tile.dart';
import 'package:jw_projekt/common/stores/user.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:jw_projekt/pages/specialist/specialist_report_menagment/widgets/priority_dropdown.dart';
import 'package:jw_projekt/styles/specialist_styles.dart';
import '../../student/YourReportInfo/widgets/commentList.dart';
import 'controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpecialistReportsMenagmentPage
    extends GetView<SpecialistReportsMenagmentConroller> {
   SpecialistReportsMenagmentPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    AppBar _buildAppBar() {
      return AppBar(
        title: Obx(() => (Text(controller.state.title.value ?? ""))),
        backgroundColor: SpecialistStyles.primaryColor,
      );
    }

    Widget _buildValueWidget(String label, RxString value) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => Text(
                value.value,
                style: const TextStyle(fontSize: 14.0),
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildContent(RxString value) {
      return Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Report: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5.w,
              ),
              Obx(
                () => Text(
                  value.value,
                  maxLines: null,
                  style: const TextStyle(fontSize: 18.0),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget _buildGoChatButton() {
      return InkWell(
        onTap: () {
          controller.goChat(controller.to_userData);
        },
        child: Container(
          alignment: Alignment.center,
          width: 360.w,
          height: 360.h / 7,
          margin: EdgeInsets.only(bottom: 10),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.green),
          child: Text(
            "Go to chat",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    Widget _buildReportBody() {
      return FutureBuilder(
        future: controller.onInit(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.connectionState == ConnectionState.done){

            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Obx(
                                  () => Text(
                                controller.state.title.value,
                                style: TextStyle(
                                    fontSize: 22.sp,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),


                          ],
                        ),
                        Obx(
                              () => Row(
                            children: [
                              const Icon(Icons.info),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                controller.state.reportType.value,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  MenuTile(child: Row(children: [
                    Text("Date: "),
                    Obx(()=>Text(controller.state.timeStamp.toString())),
                  ],), icon:Icons.calendar_month ),
                  MenuTile(
                      icon: Icons
                          .signal_wifi_statusbar_connected_no_internet_4_outlined,
                      child: Row(
                        children: [
                          const Text("Status: "),
                          InkWell(
                            onTap: () {
                              controller.showStateSelection(
                                  context, controller.state.status);
                            },
                            child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5, right: 5),
                                  child: _buildValueWidget(
                                      'Status', controller.state.status),
                                )),
                          ),
                        ],
                      )),
                  MenuTile(
                      icon: Icons.person,
                      child: Row(
                        children: [
                          const Text("Caretaker: "),
                          _buildValueWidget('Caretaker', controller.state.caretaker),
                          InkWell(
                            onTap: () {
                              controller.updateCaretaker(controller.report_id,
                                  UserStore.to.token ?? "error");
                            },
                            child: Icon(Icons.sync),
                          )
                        ],
                      )),
                  MenuTile(
                      icon: Icons.sort,
                      child: Row(
                        children: [
                          const Text("Priority: "),
                          PriorityDropdown(reportId:controller.report_id,currentValue: controller.state.priority.value,),
                        ],
                      )),





                  SizedBox(
                    height: 10.w,
                  ),
                  _buildContent(controller.state.content),
                  SizedBox(
                    height: 10.w,
                  ),
                  _buildGoChatButton(),


                ],
              ),
            );

          }
          else{
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.deepPurpleAccent,
              ),
            );
          }
        },

      );
    }


    return Scaffold(
        resizeToAvoidBottomInset: true,
      appBar: _buildAppBar(),
      body: Container(
        decoration: BoxDecoration(
          color: CupertinoColors.lightBackgroundGray,
        ),
        child: SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints.expand(),
            child: Stack(
                fit: StackFit.expand,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          controller: controller.scrollController,
                          child: Column(

                            children: [
                              Listener(
                                onPointerDown: (_) {

                                },
                                child: Container(
                                  child: _buildReportBody(),
                                  alignment: Alignment.topLeft,
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  Flexible(

                                      child: CommentList()),

                                ],
                              ),
                              SizedBox(height: 50,)
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),


                Positioned(
                    bottom: 0.h,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 360,
                              child: TextField(
                                focusNode: controller.focus,
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                controller: controller.commentContent,
                                decoration: InputDecoration(
                                  hintText: 'Add a comment...',
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                final comment =
                                    controller.commentContent.text.trim();
                                if (comment.isNotEmpty) {
                                  controller.handleSendComment(comment);
                                  controller.commentContent.clear();
                                }
                              },
                              child: Icon(Icons.send),
                            )
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
