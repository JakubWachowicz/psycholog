

import 'package:jw_projekt/pages/specialist/specialist_report_chat/widgets/chat_list.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jw_projekt/styles/specialist_styles.dart';
import 'controller.dart';

class SpecialistReportChatPage extends GetView<SpecialistReportChatConroller> {
  const SpecialistReportChatPage({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text( controller.state.report_title,
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
              child: SpecialistReportChatList(),
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
                            print(" test"+ controller.state.msgcontentList.length.toString() + "ilość wiadomości");
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
