import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jw_projekt/entities/reportComment.dart';


import '../../../../Utils/date.dart';
import '../../../../Widgets/circular_image.dart';
import '../controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CommentList extends GetView<YourReportInfoConroller> {
  const CommentList({Key? key}) : super(key: key);


  Widget _buildComment(ReportComment comment){


    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          CircularImage(
            imageUrl: 'https://images.unsplash.com/photo-1547721064-da6cfb341d50',
            size: 50.0,
          ),
          SizedBox(width: 10.w  ,),
          Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(comment.userName?? "",style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(width: 10.w,),
                  Text( duTimeLineFormat(
                   comment.timestamp!.toDate(),
                  ),),

                ],
              ),
              SizedBox(height: 10.w  ,),
              Container(
                width: 250.w,
                child: Text(comment.content??"",
                  maxLines: 4,overflow: TextOverflow.clip,),
              )
            ],
          ),
        ],
      ),
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
