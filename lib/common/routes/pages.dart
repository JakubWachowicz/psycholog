import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jw_projekt/common/routes/routes.dart';
import 'package:jw_projekt/pages/messages/bindings.dart';

import '../../pages/application/bindings.dart';
import '../../pages/application/view.dart';
import '../../pages/chat/bindings.dart';
import '../../pages/chat/view.dart';
import '../../pages/login/bindings.dart';
import '../../pages/login/view.dart';
import '../../pages/messages/view.dart';
import '../../pages/report_form/index.dart';
import '../../pages/welcome/index.dart';
import '../middlewares/router_welcome.dart';


class AppPages{

  static const INITIAL = AppRoutes.INITIAL;
  static const Application = AppRoutes.Application;
  static final RouteObserver<Route> observer = RouteObserver();
  static List<String> history = [];

  static final  List<GetPage> routes = [
    GetPage(
      name: AppRoutes.INITIAL,
      page:() => const WelcomePage(),
      binding: WelcomeBinding(),
      middlewares: [
        RouteWelcomeMiddleware(priority:1)
      ]
    ),
    GetPage(
      name: AppRoutes.Login,
      page:() => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.Application,
      page:() => ApplicationPage(),
      binding: ApplicationBinding(),
    ),
    GetPage(
      name: AppRoutes.Messages,
      page:() => MessagePage(),
      binding: MessagesBinding(),
    ),

    GetPage(
      name: AppRoutes.Chat,
      page:() => ChatPage(),
      binding: ChatBinding(),
    ),

    GetPage(
      name: AppRoutes.ReportForm,
      page:() => ReportFormPage(),
      binding: ReportFormBinding(),
    )



  ];

}