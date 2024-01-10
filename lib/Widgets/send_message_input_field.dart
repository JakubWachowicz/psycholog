import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/specialist_styles.dart';

Widget SendMessageInputField(controller){
  return Positioned(
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
                width: 300.w,
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
                  print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                  print(" test"+ controller.state.msgcontentList.length.toString() + "ilość wiadomości");
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.send),
                ),
              ),
              SizedBox(width: 8,)
            ],
          ),
        ),
      ));
}