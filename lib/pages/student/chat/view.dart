import 'package:jw_projekt/Utils/constants.dart';

import 'package:jw_projekt/pages/login/controller.dart';
import 'package:jw_projekt/pages/student/chat/widgets/chat_empty_state.dart';
import 'package:jw_projekt/pages/student/chat/widgets/chat_list.dart';
import 'package:jw_projekt/pages/welcome/controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dots_indicator/dots_indicator.dart';


import '../../../Widgets/message_input_field.dart';
import '../../../Widgets/send_message_input_field.dart';
import '../../../styles/specialist_styles.dart';
import 'controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ChatPage extends GetView<ChatConroller> {
  const ChatPage({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text( controller.state.specialist_name.value,
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
              child: Obx(()=> controller.state.msgcontentList.length==0?ChatEmptyStateWidget(controller.state.specialist_avatar.value): ChatList()),
            ),

            SendMessageInputField(controller)
          ],
        ),
      ),

      ),);
  }
}
