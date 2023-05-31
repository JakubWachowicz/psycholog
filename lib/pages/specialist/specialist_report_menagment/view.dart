import 'package:jw_projekt/common/stores/user.dart';
import 'package:jw_projekt/pages/specialist/specialist_messages/widgets/sort_button.dart';
import 'package:jw_projekt/pages/specialist/specialist_reports/widgets/report_filter.dart';
import 'package:jw_projekt/pages/specialist/specialist_reports/widgets/report_list.dart';
import 'package:jw_projekt/pages/specialist/specialist_reports/widgets/report_sort.dart';
import 'package:jw_projekt/pages/student/messages/widgets/messages_list.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../Widgets/editable_text_widget.dart';
import '../../../entities/user.dart';
import '../../student/YourReportInfo/widgets/commentList.dart';
import 'controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class SpecialistReportsMenagmentPage extends GetView<SpecialistReportsMenagmentConroller> {
  const SpecialistReportsMenagmentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBar _buildAppBar() {
      return AppBar(
        title: Obx(() => (Text(controller.state.title.value ?? ""))),
        backgroundColor: Colors.green,
      );
    }

    Widget _buildValueWidget(String label, RxString value) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Obx(
                  () => Text(
                value.value,
                style: TextStyle(fontSize: 14.0),
              ),
            ),
          ],
        ),
      );
    }


    Widget _buildContent(RxString value){
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Container(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Report: ',style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 5.w,),
              Obx(
                    () => Text(
                  value.value,
                  maxLines: null,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget _buildGoChatButton(){
      return InkWell(
        onTap: (){

          controller.goChat(controller.to_userData);
        },
        child: Container(
          alignment: Alignment.center,
          width: 360.w,
          height: 360.h/7,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.green
          ),
          child: Text("Go to chat",style: TextStyle(color: Colors.white,fontSize: 16.sp,fontWeight: FontWeight.bold),),
        ),
      );
    }


    Widget _buildReportBody() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Obx(
                      () => Text(
                    controller.state.title.value,
                    style: TextStyle(fontSize: 22.sp,color: Colors.green,fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(width: 20.w,),

                Container(child: _buildValueWidget('Timestamp', controller.state.timeStamp),alignment: Alignment.centerRight, ),
                Expanded(child: SizedBox(width: 360.w,)),

              ],
            ),

            Obx(
                  () => Text(
                controller.state.reportType.value,
                style: TextStyle(fontSize: 16.sp,color: Colors.black,fontWeight: FontWeight.bold),
              ),
            ),

            Row(
              children: [
                Text("Status: "),
                _buildValueWidget('Status', controller.state.status),
                InkWell(onTap: (){
                  controller.showStateSelection(context,  controller.state.status);
                },
                  child: Icon(Icons.change_circle),)
              ],
            ),

            Row(
              children: [
                Text("Caretaker: "),
                _buildValueWidget('Caretaker', controller.state.caretaker),
                InkWell(onTap: (){
                  controller.updateCaretaker(controller.report_id,UserStore.to.token??"error");
                },
                  child: Icon(Icons.sync),)
              ],
            ),
            Row(
              children: [
                Text("Priority: "),
                _buildValueWidget('Priority', controller.state.priority),
                InkWell(onTap: (){
                  controller.showPrioritySelection(context,  controller.state.priority);
                },
                  child: Icon(Icons.change_circle),)
              ],
            ),




            SizedBox(height: 10.w,),
            _buildContent( controller.state.content),
            SizedBox(height: 10.w,),
            _buildGoChatButton(),
            SizedBox(height: 10.w,),

            Text("Comments: "),


          ],
        ),
      );
    }



    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Container(
                      child: _buildReportBody(),
                      alignment: Alignment.topLeft,),
                    Expanded(child: CommentList()),
                  ],
                ),
              ),
              Positioned(
                  bottom: 0.h,
                  child: Container(
                    color: Colors.white70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 360,
                          child: TextField(
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
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
