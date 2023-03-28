import 'package:flutter/material.dart';

import '../../../Utils/constants.dart';


class MessageInputField extends StatefulWidget {
  final TextEditingController controller;
  const MessageInputField({Key? key,required this.controller}) : super(key: key);

  @override
  State<MessageInputField> createState() => _MessageInputFieldState();
}

class _MessageInputFieldState extends State<MessageInputField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.black87),

      controller: widget.controller,

      maxLines: null,
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.send),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.access_alarm_outlined),
        labelStyle: const TextStyle(fontSize: 20,color: Colors.black45),
        enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.black54)),
        focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: borderColor)),
      ),



    );
  }
}
