import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jw_projekt/controller/db_data_controller.dart';

import '../../../../controller/profile_data_controller.dart';

List<String> imageList = [
  'assets/avatars/hippo.jpg',
  'assets/avatars/żerafka.png',
  'assets/avatars/cat_avatar.jpg',
  'assets/avatars/tiger_avatar.png',

  // Add more image URLs as needed
];




List<bool> isSelected = List.generate(imageList.length, (index) => false);



class ImageSlider extends StatelessWidget {
  
  DbDataController dbController = DbDataController();


  Rx<int> currentIndex = 0.obs;
  AppBar _buildAppBar() {
    return AppBar(
      title: Text("Slect profile picture"),
      backgroundColor: Colors.green,
    );
  }

  ProfileDataController profileController = ProfileDataController();
  @override
  Widget build(BuildContext context) {

    Future<void> handleAvatarChange() async{
      try{
        profileController.setAvatar(imageList[currentIndex.value]);
        Navigator.pop(context);
      }
      catch(e){
        print('Error uploading to db');
      }

    }



    return Scaffold(
      appBar:_buildAppBar() ,
      body: Center(
        child: SingleChildScrollView(
          child: CarouselSlider(

            options: CarouselOptions(
              height: 400.w,
              autoPlay: false, // Enable auto play
              enlargeCenterPage: true, // Enlarge the center image
              aspectRatio: 16 / 9, // Adjust the aspect ratio as needed
              autoPlayCurve: Curves.fastOutSlowIn, // Animation curve
              enableInfiniteScroll: true, // Allow infinite scrolling
              autoPlayInterval: Duration(seconds: 3), // Auto play interval
              autoPlayAnimationDuration: Duration(milliseconds: 800), // Animation duration
              viewportFraction: 0.8,
              enlargeStrategy: CenterPageEnlargeStrategy.scale,// Amount of the screen occupied by each image

              onPageChanged: (index, _) {
                print(index);
                currentIndex.value = index;

              },

            ),

            items: imageList.map((imageUrl) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(

                      child: Column(
                        children: [

                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(
                                width: 2,
                                color: Colors.black
                              )
                            ),
                            child: Image.asset(
                              height: 200.w,
                              width: 200.w,
                              imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                         SizedBox(height: 10.h,),
                         InkWell(
                           onTap: (){
                             handleAvatarChange();
                           },
                           child: Container(
                             width: 220.w,
                             height: 50.w,
                             alignment: Alignment.center,
                             decoration: BoxDecoration(
                               color: Colors.green,
                               borderRadius: BorderRadius.all(Radius.circular(10))

                             ),
                             child: Text("Change Avatar",style: TextStyle(color:Colors.white,fontSize: 18.sp),),
                           ),
                         )

                        ],
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
