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

  Future<String?> initAvatar(Msg item) async {
    var avatar;

    avatar = await controller.db_controller.getAvatar(item.specialist_uid);

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
                        print("HOLOLOLOLO");
                        print("Error loading avatar: ${snapshot.error}");
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
    print(avatarString + "UWAGA!!!");
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 4,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      margin: EdgeInsets.only(top: 10.w),
      child: InkWell(
        onTap: () {
         controller.goChat(item);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserAvatarWidget(
                role: 'student',
                path: avatarString == null
                    ? 'assets/logo.jpg': avatarString,

                size: 54.w,
              ),
              SizedBox(width: 5.w,),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,

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
                                : item.specialist_name!,
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
                              borderRadius: BorderRadius.circular(180),
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
      ),
    );
  }
}
