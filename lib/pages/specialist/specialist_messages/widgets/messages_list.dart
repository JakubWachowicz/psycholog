import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../Utils/date.dart';
import '../../../../common/routes/routes.dart';
import '../../../../entities/messages.dart';
import '../controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class SpecialistMessageList extends GetView<SpecialistMessagesConroller> {
  const SpecialistMessageList({Key? key}) : super(key: key);

  Widget buildListItem(QueryDocumentSnapshot<Msg> item){
    return Container(
        margin: EdgeInsets.only(top: 10.w),

      child: InkWell(
        onTap: (){

          var to_uid = "";
          var to_name ="";
          var to_avatar ="";

          if(item.data().from_uid == controller.token){
            to_uid = item.data().to_uid??"";
            to_name = item.data().to_name??"";
            to_avatar = item.data().to_avatar??"";

          }else{
            to_uid = item.data().from_uid??"";
            to_name = item.data().from_name??"";
            to_avatar = item.data().from_avatar??"";
          }
         Get.toNamed(AppRoutes.SpecialistChat,parameters: {
           "doc_id":item.id,
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

                          item.data().from_uid == controller.token?item.data().to_name??"Student":item.data().from_name??"Student",
                          overflow: TextOverflow.clip,
                          maxLines: 1,

                        ),

                        Text(
                          item.data().last_msg??"",
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
                              (item.data().last_time as Timestamp).toDate(),
                          ),
                          overflow: TextOverflow.clip,
                          maxLines: 1,

                        ),
                        controller.state.unreadMsgCounter[item.id] != 0? Container(

                            decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(90)),

                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(controller.state.unreadMsgCounter[item.id].toString()??"erre",style: TextStyle(color: Colors.white),),
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
                        var item = controller.state.messageList[index];
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
