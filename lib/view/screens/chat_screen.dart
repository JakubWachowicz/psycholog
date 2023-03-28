import 'package:flutter/material.dart';

import '../../Utils/constants.dart';
import '../widgets/chat/message_input_field.dart';
import '../widgets/chat/message_recived_tile.dart';
import '../widgets/chat/message_send_tile.dart';



class ChatScreen extends StatefulWidget {
 final String userName;
 ChatScreen({Key? key, required this.userName}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.green,
        title: Text(widget.userName??"error"),
      ),
      body: Container(

        child: Column(
          children: [



            SizedBox(height: 30,),
            Expanded(child: ListView(
               reverse: true,
              children: [
                MessageRecivedTile(message: 'Help me plis', messageDate: '22:37'),
                MessageSendTile(message: 'Test message',messageDate: '14:20',),
                MessageSendTile(message: 'Bardzo długo wiadomosć, ojojoj jaka długaaaaa wiadomość',messageDate: '11:21',),
                MessageRecivedTile(message: 'Help me plis', messageDate: '22:37'),
                MessageRecivedTile(message: 'Help me plis', messageDate: '22:37'),







          ],
            )),
            MessageInputField(controller: TextEditingController())
          ],
        ),
      ),
    );
  }
}
