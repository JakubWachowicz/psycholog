
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:jw_projekt/entities/user.dart';


import '../../../../Widgets/user_avatar.dart';
import '../../../../entities/messages.dart';
import '../controller.dart';



class ContactList extends GetView<ContactConroller> {
   ContactList({Key? key}) : super(key: key);


  Future<String?> initAvatar(id) async {
    var avatar;
    avatar = await controller.dbDataController.getAvatar(id);

    if(avatar =='testPhoto'){
      return "assets/logo.jpg";
    }
    return avatar;
  }


  String? string_avatar = "";
  Widget buildListItem(UserData item){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        alignment: Alignment.center,

          margin: EdgeInsets.only(top: 10.w),

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(
                color: Colors.white70,
                width: 300.w,

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [


                          Row(
                            children: [
                              Container(
                                  margin:  new EdgeInsets.only(right: 10),
                                  child: UserAvatarWidget(role: 'student', path: string_avatar!,size: 85,)),
                              Text(
                                item.name??"error",
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                                style: TextStyle(fontSize: 24.sp,fontWeight: FontWeight.bold),

                              ),
                            ],
                          ), Container(
                            decoration: BoxDecoration(
                              color: Colors.white70
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                controller.state.specialistList.value.where((element) => element.id == item.id).toList().isNotEmpty?
                                controller.state.specialistList.value.where((element) => element.id == item.id).toList().last.description??"lol":"lol"

                              ),
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

                          ),
                          SizedBox(height: 10.w,)


                        ],
                      ),
                    ),

                  ],
                ),
              )

            ],
          ),
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
                      return  FutureBuilder<String?>(
                          future: initAvatar(item.id),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              string_avatar = snapshot.data;
                              return buildListItem(item);
                            } else {
                              return SizedBox();
                            }
                        });

                    },
                    childCount: controller.state.messageList.length
                ),
              ),),

          ],
        )
    );
  }
}
