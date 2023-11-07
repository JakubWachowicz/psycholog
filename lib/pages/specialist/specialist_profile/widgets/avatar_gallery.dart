import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../controller/profile_data_controller.dart';
const List<String> imageList = [
  'assets/avatars/hippo.jpg',
  'assets/avatars/żerafka.png',
  'assets/avatars/cat_avatar.jpg',
  'assets/avatars/cat_avatar.jpg',
  'assets/avatars/cat_avatar.jpg',
  'assets/avatars/cat_avatar.jpg',
  'assets/avatars/cat_avatar.jpg',
  'assets/avatars/cat_avatar.jpg',
  'assets/avatars/cat_avatar.jpg',

  'assets/avatars/tiger_avatar.png',

  // Add more image URLs as needed
];



class AvatarGallery extends StatefulWidget {
  AvatarGallery({super.key,required this.avatar});
  String avatar;

  @override
  State<AvatarGallery> createState() => _AvatarGalleryState();
}

class _AvatarGalleryState extends State<AvatarGallery> {
  ProfileDataController profileController = ProfileDataController();

  Future<void> handleAvatarChange(url) async{
    try{
      profileController.setAvatar(url);
    }
    catch(e){
      print('Error uploading to db');
    }

  }

  InkWell createAvatar(String url,double imgWidth){
    return InkWell(
      onTap: (){
        handleAvatarChange(url);
        setState(() {
          widget.avatar = url;
        });
      },
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(border: Border.all(width: 2.0, color: Colors.black),boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ], ),
          child: Image.asset(url,width: imgWidth,height: imgWidth,)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Choose an avatar"),backgroundColor: Colors.green,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Your Avatar",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              createAvatar(widget.avatar, 150,),
              SizedBox(height: 20,),
              Text("Avatars",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
              GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                children: imageList.map((url) => createAvatar(url,60)).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
