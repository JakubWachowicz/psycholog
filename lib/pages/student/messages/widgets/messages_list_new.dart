import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../Utils/date.dart';
import '../../../../Widgets/user_avatar.dart';
import '../../../../entities/messages.dart';
import '../controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MessageListNew extends GetView<MessagesConroller> {
  MessageListNew({Key? key}) : super(key: key);

  Future<String?> initAvatar(item) async {
    var avatar;
    if (item.to_uid == controller.token) {
      avatar = await controller.db_controller.getAvatar(item.from_uid);
    } else {
      avatar = await controller.db_controller.getAvatar(item.to_uid);
    }
    return avatar;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 0.w, horizontal: 0.w),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  var item = controller.state.messages[index];
                  return FutureBuilder<String?>(
                    future: initAvatar(item),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        String avatarString = snapshot.data ?? '';
                        return buildListItem(item, avatarString);
                      } else if (snapshot.hasError) {
                        return Text('Error loading avatar');
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  );
                },
                childCount: controller.state.messages.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListItem(Msg item, String avatarString) {
    return Container(
      margin: EdgeInsets.only(top: 10.w),
      child: InkWell(
        onTap: () {
          var to_uid = "";
          var to_name = "";
          var to_avatar = "";

          if (item.from_uid == controller.token) {
            to_uid = item.to_uid ?? "";
            to_name = item.to_name ?? "";
            to_avatar = item.to_avatar ?? "";
          } else {
            to_uid = item.from_uid ?? "";
            to_name = item.from_name ?? "";
            to_avatar = item.from_avatar ?? "";
          }
          Get.toNamed("/chat", parameters: {
            "doc_id": item.messageId!,
            "to_uid": to_uid,
            "to_name": to_name,
            "to_avatar": to_avatar,
            "from_name": controller.name,
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserAvatarWidget(
              role: 'student',
              path: avatarString == null
                  ? 'assets/logo.jpg'
                  : avatarString.contains('assets')
                  ? avatarString
                  : 'assets/logo.jpg',
              size: 54.w,
            ),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200.w,
                    height: 42.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.message_type != null
                              ? item.message_type!
                              : item.to_name!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                          ),
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                        ),
                        Text(
                          item.last_msg ?? "",
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 60.w,
                    height: 54.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          duTimeLineFormat(
                            (item.last_time as Timestamp).toDate(),
                          ),
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                        ),
                        item.unreadMessagesCountStudent != 0 &&
                            item.unreadMessagesCountStudent != null
                            ? Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(90),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              item.unreadMessagesCountStudent.toString()!,
                            ),
                          ),
                        )
                            : Text(""),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
