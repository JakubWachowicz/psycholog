
import 'package:flutter/material.dart';

import '../../../Utils/constants.dart';

class MessageSendTile extends StatelessWidget {


  final String messageDate;
  final String message;

  MessageSendTile({Key? key,required this.message,required this.messageDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),


      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.end,

        children: [


          Container(


            constraints: BoxConstraints(maxWidth: screenWidth*0.8),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.greenAccent,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(message),
            ) ,

          ),

          Padding(
            padding: const EdgeInsets.only(right: 6,bottom: 10),
            child: Text(messageDate),
          ),

        ],
      ),

    );
  }
}
