import 'package:jw_projekt/pages/student/messages/widgets/messages_list.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:jw_projekt/pages/student/messages/widgets/messages_list_new.dart';
import 'controller.dart';

class MessagePage extends GetView<MessagesConroller> {
  const MessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    AppBar _buildAppBar(){
      return AppBar(
        title: Text("Messages"),
        backgroundColor: Colors.green,
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
