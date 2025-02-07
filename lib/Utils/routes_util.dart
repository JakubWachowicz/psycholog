

import 'package:get/get.dart';
import 'package:jw_projekt/view/screens/chat_screen.dart';

import '../model/chat.dart';

import '../view/screens/home_screen.dart';

class RoutesUtil{

  static const String _home = "/";
  static const String _login = "/login";
  static const String _signup = "/signup";
  static const String _confirm = "/confirm";
  static const String _chat = "/chat";


  static String temp = "l";
  static late Chat chat;

  static String getHomeRoute()=>_home;
  static String getLoginRoute()=>_login;
  static String getSignupRoute()=>_signup;
  static String getConfirmVideo()=>_confirm;
  static String getChat(String chatId,Chat newChat) {
    temp = chatId;
    chat = newChat;
    return _chat;
  }



  static List<GetPage> routes = [
    GetPage(name: _home, page: ()=>HomeScreen()),

    GetPage(name: _chat, page: ()=>ChatScreen(userName: temp,chat: chat,)),
  ];
}
