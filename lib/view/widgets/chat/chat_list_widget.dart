import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jw_projekt/view/widgets/chat/chat_tile.dart';
import '../../../Utils/constants.dart';
import '../../../model/chat.dart';

class ChatListWidget extends StatefulWidget {
  ChatListWidget({Key? key, required this.chats}) : super(key: key);
  List<Chat> chats;

  @override
  State<ChatListWidget> createState() => _ChatListWidgetState();
}

class _ChatListWidgetState extends State<ChatListWidget> {
  @override
  Widget build(BuildContext context) {
      return Container(
        child: ListView.builder(itemCount: widget.chats.length,
          itemBuilder: (BuildContext context, int index) {
            return ChatTile(
              user: widget.chats[index].firstUserId !=
                firebaseAuth.currentUser!.uid
                ? widget.chats[index].firstUserId
                : widget.chats[index].secondUserId,
              chatId: widget.chats[index],


            );
          },),
      );
  }
}
