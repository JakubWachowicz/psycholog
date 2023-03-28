
import 'package:flutter/material.dart';
import 'package:jw_projekt/Utils/color_util.dart';

import '../../../Utils/constants.dart';

class MessageRecivedTile extends StatelessWidget {


  final String messageDate;
  final String message;

  MessageRecivedTile({Key? key,required this.message,required this.messageDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),


      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          Container(


            constraints: BoxConstraints(maxWidth: screenWidth*0.8),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: "#e3e3e3".toColor(),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(message),
            ) ,

          ),

          Padding(
            padding: const EdgeInsets.only(left: 6,bottom: 10),
            child: Text(messageDate),
          ),

        ],
      ),

    );
  }
}
