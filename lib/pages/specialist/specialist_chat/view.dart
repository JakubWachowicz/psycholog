import 'package:jw_projekt/Utils/constants.dart';

import 'package:jw_projekt/pages/login/controller.dart';
import 'package:jw_projekt/pages/specialist/specialist_chat/widgets/chat_list.dart';
import 'package:jw_projekt/pages/student/chat/widgets/chat_list.dart';
import 'package:jw_projekt/pages/welcome/controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:jw_projekt/styles/specialist_styles.dart';


import 'controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SpecialistChatPage extends GetView<SpecialistChatConroller> {
  const SpecialistChatPage({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text( controller.state.student_name.value!,
        overflow: TextOverflow.clip,
        maxLines: 1,),
        backgroundColor: SpecialistStyles.primaryColor,

      ),
      
      body: SafeArea(child:ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          children: [

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SpecialistChatList(),
            ),

            Positioned(
                bottom: 0.h,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: SpecialistStyles.backgroundColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 360,
                          child: TextField(
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            controller: controller.textController,
                            decoration: InputDecoration(
                              hintText: 'Send message',
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.sendMessage();
                          },
                          child: Icon(Icons.send),
                        )
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),

      ),);
  }
}
