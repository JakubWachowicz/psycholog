import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jw_projekt/entities/reportComment.dart';


import '../../../../Utils/date.dart';
import '../controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CommentList extends GetView<YourReportInfoConroller> {
  const CommentList({Key? key}) : super(key: key);


  Widget _buildComment(ReportComment comment){


    return Column(

      children: [
        Row(
          children: [
            Text(comment.uid?? ""),
            Text( duTimeLineFormat(
             comment.timestamp!.toDate(),
            ),),

          ],
        ),
        Text(comment.content??"")
      ],
    );

  }
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

                      var item = controller.state.commentList[index];
                      print(item.uid);
                      return _buildComment(item);

                    },
                    childCount: controller.state.commentList.length
                ),
              ),),

            ],
          ),
        )
    );
  }
}
