import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jw_projekt/common/routes/routes.dart';
import 'package:jw_projekt/pages/specialist/specialist_application/view.dart';
import '../../pages/admin/admin_application/index.dart';
import '../../pages/login/bindings.dart';
import '../../pages/login/view.dart';
import '../../pages/specialist/specialist_application/bindings.dart';
import '../../pages/specialist/specialist_chat/index.dart';
import '../../pages/specialist/specialist_report_menagment/index.dart';
import '../../pages/student/application/index.dart';
import '../../pages/student/chat/index.dart';
import '../../pages/student/messages/index.dart';
import '../../pages/student/report_form/index.dart';
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
      name: AppRoutes.AdminApplication,
      page:() => AdminApplicationPage(),
      binding: AdminApplicationBinding(),
    ),

    GetPage(
      name: AppRoutes.SpecialistApplication,
      page:() => SpecialistApplicationPage(),
      binding: SpecialistApplicationBinding(),
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
      name: AppRoutes.SpecialistChat,
      page:() => SpecialistChatPage(),
      binding: SpecialistChatBinding(),
    ),

    GetPage(
      name: AppRoutes.ReportForm,
      page:() => ReportFormPage(),
      binding: ReportFormBinding(),
    ),

    GetPage(
      name: AppRoutes.SpecialistReportMenagment,
      page:() => SpecialistReportsMenagmentPage(),
      binding: SpecialistReportMenagmentBinding(),
    )



  ];

}