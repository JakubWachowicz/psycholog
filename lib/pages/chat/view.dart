import 'package:jw_projekt/Utils/constants.dart';
import 'package:jw_projekt/pages/chat/widgets/chat_list.dart';
import 'package:jw_projekt/pages/login/controller.dart';
import 'package:jw_projekt/pages/welcome/controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../../view/widgets/text_input_field.dart';
import 'controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ChatPage extends GetView<ChatConroller> {
  const ChatPage({Key? key}) : super(key: key);


  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
            color: Colors.green
        ),

      ),
      title: Container(

        padding: EdgeInsets.only(),
        child: Row(

          children: [
            Container(
              padding: EdgeInsets.only(),
              child: InkWell(
                child: SizedBox(
                  width: 44.w,
                  height: 44.w,
                  child: CachedNetworkImage(
                    imageUrl: controller.state.to_avatar.value,
                    imageBuilder: (context, imageProvider) =>
                        Container(
                          height: 44.w,
                          width: 44.w,
                          margin: null,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  44.w)),
                              image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover
                              )
                          ),
                        ),
                    errorWidget: (context, url, error) =>
                        Image(image: AssetImage('assets/logo.jpg'),),

                  ),
                ),
              ),
            ),
            SizedBox(height: 15.w,),
            Container(
              width: 180.w,
              padding: EdgeInsets.only(),
              child: Row(
                children: [
                  SizedBox(
                    width: 180.w,
                    height: 44.w,
                    child: GestureDetector(
                      onTap: () {},
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller.state.to_name.value,
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                            style: TextStyle(fontFamily: 'Avenir',
                                fontWeight: FontWeight.bold,
                                color: backGroundColor,
                                fontSize: 16.sp),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),

            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text( controller.state.to_name.value,
        overflow: TextOverflow.clip,
        maxLines: 1,),
        backgroundColor: Colors.green,

      ),
      body: SafeArea(child:ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          children: [

            ChatList(),

              Positioned(
                bottom:  0.h,
                height: 50.h,

                  child: Container(

                    color: Colors.white70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        //Text input field
                        Container(
                          width: 360.w,
                          height: 50.w,
                          child: TextField(

                            keyboardType: TextInputType.multiline,
                            maxLines: 3,
                            controller: controller.textController,
                            autofocus: false,
                            focusNode: controller.contentNode,

                            decoration: InputDecoration(

                              filled: true,
                              hintText: "Send Message",
                              fillColor: Colors.white,
                              suffixIcon: IconButton(icon:Icon(Icons.send), onPressed: () {  controller.sendMessage(); },),
                              labelStyle: const TextStyle(fontSize: 20,color: Colors.black45),
                              enabledBorder:  OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(color: Colors.black54)),
                              focusedBorder:  OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(color: borderColor)),
                            ),



                          ),
                        ),



                      ],
                    ),
              ))
          ],
        ),
      ),

      ),);
  }
}
