import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jw_projekt/pages/student/YourReportInfo/widgets/commentList.dart';
import 'package:jw_projekt/pages/student/your_reports/widgets/your_reports_list.dart';
import 'controller.dart';

class YourReportInfoPage extends GetView<YourReportInfoConroller> {
  const YourReportInfoPage({Key? key}) : super(key: key);

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
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 4.0),
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

    Widget _buildReportBody() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildValueWidget('Title', controller.state.title),
          _buildValueWidget('Report Category', controller.state.reportType),
          _buildValueWidget('Content', controller.state.content),
          _buildValueWidget('Status', controller.state.status),
          _buildValueWidget('Timestamp', controller.state.timeStamp),
        ],
      );
    }

    Widget _buildCommentSection() {
      return Container(
        height: 100,
        child: Column(children: [
          Expanded(
            child: TextField(
              controller: controller.commentContent,
              decoration: InputDecoration(
                hintText: 'Add a comment...',
              ),
            ),
          ),
          IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                final comment = controller.commentContent.text.trim();
                if (comment.isNotEmpty) {
                  controller.handleSendComment(comment);
                  controller.commentContent.clear();
                }
              })
        ]),
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
                child: _buildReportBody(),
              ),
              CommentList(),
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
