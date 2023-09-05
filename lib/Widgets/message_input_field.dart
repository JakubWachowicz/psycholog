

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageInputField extends StatelessWidget {

  final Future<String>sendMessage;
  TextEditingController controller = TextEditingController();
  MessageInputField({Key? key, required this.sendMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Positioned(
        bottom: 0.h,
        child: Container(
          color: Colors.white70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 360.w-30.w,
                child: TextField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Add a comment...',
                  ),
                ),
              ),

              InkWell(
                onTap: () {
                  final comment =
                  controller.text.trim();
                  if (comment.isNotEmpty) {
                    sendMessage;
                    controller.clear();
                  }
                },
                child: Icon(Icons.send),
              )
            ],
          ),
        ));
  }
}











