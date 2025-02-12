import 'package:flutter/material.dart';

import '../../utils/constants.dart';

import 'package:get/get.dart';
class DummyClass{

  DummyClass(bool isValid){
    this.isValid =isValid;
  }
  bool isValid = true;
}
class TextInputField extends StatefulWidget {

  final TextEditingController controller;
  final String labelText;
  final IconData  icon;
  final bool isObscured;
  final String errorMessage;



  const TextInputField({Key? key, required this.controller, required this.labelText, required this.icon, required this.isObscured, required this.errorMessage}) : super(key: key);


  @override
  State<TextInputField> createState() => TextInputFieldState();


  void setIsValid(bool isValid) {

    //dummyClass.isValid = false;
    isValid = false;

  }


}


class TextInputFieldState extends State<TextInputField> {
  bool showSuffix = true;

  @override
  Widget build(BuildContext context) {


    return  Column(
      children: [

        TextField(

          style: TextStyle(color: Colors.black87),


          controller: widget.controller,
          decoration: InputDecoration(

            filled: true,
            fillColor: Colors.white,
            labelText: widget.labelText,
            prefixIcon: Icon(widget.icon, color: borderColor,),
            suffixIcon: widget.isObscured?GestureDetector(onTap:(){
              setState(() {
                showSuffix = !showSuffix;
              });
            } ,child: Icon(showSuffix? Icons.visibility:Icons.visibility_off, color: borderColor,),):null,
            labelStyle: const TextStyle(fontSize: 20,color: Colors.black45),
            enabledBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: Colors.black54)),
            focusedBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: borderColor)),
          ),
          obscureText: widget.isObscured? showSuffix:false,


        ),
      ],
    );
  }
}