import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'chat_left_item.dart';
import 'chat_right_item.dart';
class SpecialistChatList extends GetView<SpecialistChatConroller> {
  const SpecialistChatList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
        ()=> Container(
          color: Colors.white,
          padding: EdgeInsets.only(bottom: 50.h),
          child: CustomScrollView(
            reverse: true,
            controller: controller.msgScrolling,
            slivers: [
              SliverPadding(padding: EdgeInsets.symmetric(vertical: 0.w,horizontal: 0.w),sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                        (context,index){
                          print("Coś tu nie działą");
                          print(controller.user_id);

                      var item = controller.state.msgcontentList[index];
                          print(item.uid);
                      if(controller.user_id == item.uid){
                        print("yep");
                        return ChatRightItem(item);
                      }
                      else{
                        print("yep");
                        return ChatLeftItem(item);
                      }

                    },
                  childCount: controller.state.msgcontentList.length
                ),
              ),),

            ],
          ),
        )
    );
  }
}
