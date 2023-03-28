

import 'package:get/get.dart';
import 'package:jw_projekt/view/screens/chat_screen.dart';

import '../view/screens/auth/login_screen.dart';
import '../view/screens/auth/signup_screen.dart';
import '../view/screens/home_screen.dart';

class RoutesUtil{

  static const String _home = "/";
  static const String _login = "/login";
  static const String _signup = "/signup";
  static const String _confirm = "/confirm";
  static const String _chat = "/chat";


  static String temp = "l";

  static String getHomeRoute()=>_home;
  static String getLoginRoute()=>_login;
  static String getSignupRoute()=>_signup;
  static String getConfirmVideo()=>_confirm;
  static String getChat(String username) {
    temp = username;
    return _chat;
  }



  static List<GetPage> routes = [
    GetPage(name: _home, page: ()=>HomeScreen()),
    GetPage(name: _login, page: ()=>LoginScreen()),
    GetPage(name: _signup, page: ()=>SignUpScreen()),
    GetPage(name: _chat, page: ()=>ChatScreen(userName: temp)),
  ];
}
