import 'package:flutter/material.dart';
import 'package:jw_projekt/Utils/constants.dart';

import '../widgets/chat/chat_tile.dart';

class ChatMenu extends StatefulWidget {
  const ChatMenu({Key? key}) : super(key: key);

  @override
  State<ChatMenu> createState() => _ChatMenuState();
}

class _ChatMenuState extends State<ChatMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(

      alignment: Alignment.center,
      
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,


        children: [



          Expanded(
            child: ListView(
              
              children: [
                ChatTile(user:'Gosia'),
                ChatTile(user:'Henry'),
                ChatTile(user:'Zofia'),
                ChatTile(user:'Anna'),


              ],
            ),
          )

        ],
      ),
    );
  }
}
