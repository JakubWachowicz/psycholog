import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jw_projekt/entities/msg_content.dart';
import 'package:jw_projekt/styles/specialist_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../Widgets/user_avatar.dart';
import '../../../specialist/specialist_chat/widgets/chat_left_item.dart';

Widget ChatEmptyStateWidget(photoUrl){
  if(photoUrl == "testPhoto"){
    photoUrl ="assets/logo.jpg";
  }
  return Container(
      alignment: AlignmentDirectional.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 100,
          backgroundColor: Colors.green,
          child: Padding(
            padding: const EdgeInsets.all(5), // Border radius
            child: ClipOval(child: Image.asset(photoUrl)),
          ),
        ),
        BuildDescription()

      ],
    )
  );
}


Widget BuildDescription(){
  return  Padding(
    padding: const EdgeInsets.all(12.0),
    child: Container(
      decoration: SpecialistStyles.decoration,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text("How can i Help you?"),
      ),),
  );
}


