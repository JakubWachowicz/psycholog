
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:jw_projekt/pages/student/messages/widgets/messages_list_new.dart';
import 'package:jw_projekt/pages/student/messages/widgets/specialist_list.dart';
import '../../../Widgets/nav_bar.dart';
import '../../../Widgets/student_appbar.dart';
import 'controller.dart';

class MessagePage extends GetView<MessagesConroller> {
  const MessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    StudentAppBar _buildAppBar(){
      return StudentAppBar(title:"Wiadomości");
    }

    print(controller.state.messageList.length);
    return Scaffold(
      drawer: NavBar(),
        floatingActionButton: FloatingActionButton(
          child: Container(
            width: 100,height: 100,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(45)
            ),
            child: Icon(Icons.add,size: 32,),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Choose_Specialist(

                  )),
            );


          },

        ),

        appBar: _buildAppBar(),
        body: Container(

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MessageListNew(),
          ),
        ));
  }
}
