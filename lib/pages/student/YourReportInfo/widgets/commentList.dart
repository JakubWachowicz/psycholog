import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jw_projekt/entities/reportComment.dart';
import '../../../../Utils/date.dart';
import '../../../../Widgets/circular_image.dart';
import '../../../../Widgets/user_avatar.dart';
import '../controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentList extends GetView<YourReportInfoConroller> {
  CommentList({Key? key}) : super(key: key);

  String? string_avatar = "";

  Future<String?> initAvatar(String uid) async {
    var avatar = await controller.db_controller.getAvatar(uid);
    return avatar;
  }

  Widget _buildComment(ReportComment comment) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          UserAvatarWidget(
            role: 'student',
            path: string_avatar == null
                ? 'assets/logo.jpg'
                : string_avatar!.contains('assets')
                ? string_avatar!
                : 'assets/logo.jpg',
            size: 54.w,
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    comment.userName ?? "",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    duTimeLineFormat(
                      comment.timestamp!.toDate(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.w),
              Container(
                width: 250.w,
                child: Text(
                  comment.content ?? "",
                  maxLines: 4,
                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Container(

            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),

            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(

                maxHeight: 300.0,
              ),
              child: Container(


        color: Colors.white,

        child: CustomScrollView(
              reverse: true,
              controller: controller.msgScrolling,
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 0.w, horizontal: 0.w),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        var item = controller.state.commentList[index];
                        return FutureBuilder<String?>(
                          future: initAvatar(item.uid!),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              string_avatar = snapshot.data;
                              return _buildComment(item);
                            } else {
                              return SizedBox();
                            }
                          },
                        );
                      },
                      childCount: controller.state.commentList.length,
                    ),
                  ),
                ),
              ],
        ),
      ),
            ),
          ),
    );
  }
}
