
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:jw_projekt/pages/student/messages/widgets/messages_list_new.dart';
import 'package:jw_projekt/pages/student/profile/widgets/edit_user_avatar.dart';
import '../../../Widgets/nav_bar.dart';
import '../../../controller/profile_data_controller.dart';
import 'controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends GetView<ProfileConroller> {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBar _buildAppBar() {
      return AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.green,
      );
    }

    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(left: 35.w,right: 35.w,top:40.w),
        child: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: Stack(
            children: [
              Obx(()=>

                Container(
                  width: 130.w,
                  height: 130.w,
                  decoration: BoxDecoration(
                    border: Border.all(width: 4,color: Colors.green),
                    boxShadow: [BoxShadow(
                        spreadRadius: 2,
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.1))
                    ],
                    shape: BoxShape.circle,
                    image:DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(ProfileDataController.profileAvatar.value)

                    ),
                  ),
                )
              ),

              Positioned(bottom:0,right:0,child: InkWell(
                onTap: (){
                  print('lol');

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>ImageSlider()),
                  );



                },
                child: Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 4,color: Colors.green),
                    color: Colors.green
                  ),
                  //color:Colors.white,
                  child: Icon(Icons.edit,color: Colors.white,),
                ),
              )),

            ],
          ),
        ),
      )
    );
  }
}
