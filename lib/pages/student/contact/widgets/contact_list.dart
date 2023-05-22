
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:jw_projekt/entities/user.dart';


import '../controller.dart';



class ContactList extends GetView<ContactConroller> {
  const ContactList({Key? key}) : super(key: key);

  Widget buildListItem(UserData item){
    return Container(
      alignment: Alignment.center,
        color: Colors.white70,
        margin: EdgeInsets.only(top: 10.w),

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: SizedBox(
                  width: 54.w,
                  height: 54.w,
                  child:Image(image: AssetImage('assets/logo.jpg'),),//CachedNetworkImage(imageUrl:"${item.photourl}"),
              ),
            ),
            Container(
              color: Colors.white70,
              width: 300.w,
              height: 150.h,
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [


                        Text(
                          item.name??"error",
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                          style: TextStyle(fontSize: 24.sp,fontWeight: FontWeight.bold),

                        ), Container(
                          decoration: BoxDecoration(
                            color: Colors.white70
                          ),
                          child: Text(
                            controller.state.specialistList.value.where((element) => element.id == item.id).toList().isNotEmpty?
                            controller.state.specialistList.value.where((element) => element.id == item.id).toList().last.description??"lol":"lol"

                          ),
                        ),

                        InkWell(
                          onTap: () =>controller.goChat(item),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10.w)), color: Colors.green,
                            ),
                            width: double.infinity,
                            height: 60.w,

                            child: Center(child: Text("Message me",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.sp),)),
                          ),

                        )


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
        ()=> CustomScrollView (
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
        )
    );
  }
}
