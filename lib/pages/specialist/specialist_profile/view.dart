
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:jw_projekt/pages/specialist/specialist_profile/widgets/avatar_gallery.dart';
import 'package:jw_projekt/pages/specialist/specialist_profile/widgets/edit_description.dart';
import 'package:jw_projekt/pages/student/messages/widgets/messages_list_new.dart';
import 'package:jw_projekt/pages/student/profile/widgets/edit_user_avatar.dart';
import 'package:jw_projekt/styles/specialist_styles.dart';
import '../../../Widgets/nav_bar.dart';
import '../../../controller/profile_data_controller.dart';
import '../../../controller/upload_image_controller.dart';
import 'controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpecialistProfilePage extends GetView<SpecialistProfileConroller> {
  const SpecialistProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBar _buildAppBar() {
      return AppBar(
        title: Text("Profile"),
        backgroundColor: SpecialistStyles.primaryColor,
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
          child: Column(
            children: [
              Stack(
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

                      /*Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>AvatarGallery(avatar: controller.image.value ,)),
                      );*/
                      UploadImageController().uploadImage(StorageCollections.profileImage, controller.token);




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
              SizedBox(height: 30,),
              Container(
                height: 200,

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Obx(() => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(controller.state.description.value),
                    ),),
                    Positioned(bottom:5,right:5,child: InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>EditDescription(descritpion: controller.state.description,specialistController: controller.specialistDbController,)),
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
              )

            ],
          ),

        ),
      )
    );
  }
}
