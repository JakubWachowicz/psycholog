import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:jw_projekt/styles/specialist_styles.dart';
import '../../../../Utils/date.dart';
import '../../../../Widgets/user_avatar.dart';
import '../../../../common/routes/routes.dart';
import '../../../../entities/messages.dart';
import '../controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SpecialistMessageListNew extends GetView<SpecialistMessagesConroller> {
  SpecialistMessageListNew({Key? key}) : super(key: key);

  Future<String?> initAvatar(Msg item) async {
    var avatar;

    avatar = await controller.db_controller.getAvatar(item.student_uid);

    print(avatar + "HAHAH");
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
                  var item = controller.state.filteredMessages[index];
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
                childCount: controller.state.filteredMessages.length,
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
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      margin: EdgeInsets.only(top: 10.w),
      child: InkWell(
        onTap: () {
          controller.dbDataController.goChatByMsg(item);
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
                    ? 'assets/logo.jpg'
                    : avatarString.contains('assets')
                        ? avatarString
                        : 'assets/logo.jpg',
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
                                : item.student_name!,
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
                          item.unreadMessagesCountSpecialist != 0 &&
                                  item.unreadMessagesCountSpecialist != null
                              ? Container(
                                  decoration: BoxDecoration(
                                    color: SpecialistStyles.primaryColor,
                                    borderRadius: BorderRadius.circular(90),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      item.unreadMessagesCountSpecialist
                                          .toString()!,
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
