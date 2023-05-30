import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../Utils/date.dart';
import '../../../../entities/messages.dart';
import '../controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class MessageListNew extends GetView<MessagesConroller> {
  const MessageListNew({Key? key}) : super(key: key);

  Widget buildListItem(Msg item){
    return Container(
      margin: EdgeInsets.only(top: 10.w),

      child: InkWell(
        onTap: (){

          var to_uid = "";
          var to_name ="";
          var to_avatar ="";

          if(item.from_uid == controller.token){
            to_uid = item.to_uid??"";
            to_name = item.to_name??"";
            to_avatar = item.to_avatar??"";

          }else{
            to_uid = item.from_uid??"";
            to_name = item.from_name??"";
            to_avatar = item.from_avatar??"";
          }
          Get.toNamed("/chat",parameters: {
            "doc_id":item.messageId!,
            "to_uid":to_uid,
            "to_name":to_name,
            "to_avatar":to_avatar,
            "from_name": controller.name
          });

        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: SizedBox(
                width: 54.w,
                height: 54.w,
                child:Image(image: AssetImage('assets/logo.jpg'),),//CachedNetworkImage(imageUrl:"${item.photourl}"),
              ),
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

                          item.from_uid == controller.token?item.to_name??"Student":item.from_name??"Student",
                          overflow: TextOverflow.clip,
                          maxLines: 1,

                        ),

                        Text(
                          item.last_msg??"",
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
                        controller.state.unreadMsgCounter[item.messageId] != 0 && controller.state.unreadMsgCounter[item.messageId] != null ? Container(

                            decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(90)),

                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(controller.state.unreadMsgCounter[item.messageId].toString()??"erre",style: TextStyle(color: Colors.white),),
                            )):Text("")
                      ],
                    ),
                  ),

                ],
              ),
            )

          ],
        ),

      ),

    );
  }
  @override
  Widget build(BuildContext context) {






    return Obx(
            ()=> SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          controller: controller.refreshController,
          onLoading: controller.onLoading,
          onRefresh: controller.onRefresh,
          header: const WaterDropHeader(),
          child: CustomScrollView (
            slivers: [
              SliverPadding(padding: EdgeInsets.symmetric(vertical: 0.w,horizontal: 0.w),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                          (context,index){
                        var item = controller.state.messages[index];
                        return buildListItem(item);

                      },
                      childCount: controller.state.messageList.length
                  ),
                ),),

            ],
          ),
        )
    );
  }
}
