import 'package:flutter/material.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../../../Utils/routes_util.dart';

class ChatTile extends StatefulWidget {

  final String user;
  const ChatTile({Key? key, required this.user}) : super(key: key);

  @override
  State<ChatTile> createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        print('lol');
        Get.toNamed(RoutesUtil.getChat(widget.user));

      },
      child: Container(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.person),
              SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.user,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [

                      Icon(Icons.check),
                      SizedBox(width: 10,),
                      Text('Testowa wiadomość'),],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
