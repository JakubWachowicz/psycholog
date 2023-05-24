import 'package:jw_projekt/Utils/constants.dart';

import 'package:jw_projekt/pages/login/controller.dart';
import 'package:jw_projekt/pages/specialist/specialist_chat/widgets/chat_list.dart';
import 'package:jw_projekt/pages/student/chat/widgets/chat_list.dart';
import 'package:jw_projekt/pages/welcome/controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dots_indicator/dots_indicator.dart';


import 'controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SpecialistChatPage extends GetView<SpecialistChatConroller> {
  const SpecialistChatPage({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text( controller.name,
        overflow: TextOverflow.clip,
        maxLines: 1,),
        backgroundColor: Colors.green,

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
                bottom:  0.h,


                  child: Container(

                    color: Colors.white70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        //Text input field
                        SizedBox(

                          width: 360.w,
                          height:  80.w,
                          child: TextField(
                            expands: true,
                            keyboardType: TextInputType.multiline,

                            maxLines: null,
                            controller: controller.textController,
                            autofocus: false,
                            focusNode: controller.contentNode,

                            decoration: InputDecoration(

                              filled: true,
                              hintText: "Send Message",
                              fillColor: Colors.white,
                              suffixIcon: IconButton(icon:Icon(Icons.send), onPressed: () {  controller.sendMessage(); },),
                              labelStyle: const TextStyle(fontSize: 20,color: Colors.black45),
                              enabledBorder:  OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(color: Colors.black54)),
                              focusedBorder:  OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(color: borderColor)),
                            ),



                          ),
                        ),



                      ],
                    ),
              ))
          ],
        ),
      ),

      ),);
  }
}
