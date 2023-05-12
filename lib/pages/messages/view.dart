import 'package:jw_projekt/Utils/constants.dart';
import 'package:jw_projekt/pages/login/controller.dart';
import 'package:jw_projekt/pages/messages/widgets/messages_list.dart';
import 'package:jw_projekt/pages/welcome/controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../../controller/message_controller.dart';
import '../../view/widgets/text_input_field.dart';
import 'controller.dart';

class MessagePage extends GetView<MessagesConroller> {
  const MessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    AppBar _buildAppBar(){
      return AppBar(
        title: Text("Messages"),
      );
    }

    print(controller.state.messageList.length);
    return Scaffold(

        appBar: _buildAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MessageList(),
        ));
  }
}
