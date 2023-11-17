import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jw_projekt/common/routes/routes.dart';
import 'package:jw_projekt/pages/settings/index.dart';
import 'package:jw_projekt/pages/specialist/specialist_application/view.dart';
import 'package:jw_projekt/pages/specialist/specialist_profile/index.dart';
import 'package:jw_projekt/pages/student/YourReportInfo/index.dart';
import '../../pages/admin/admin_application/index.dart';
import '../../pages/login/bindings.dart';
import '../../pages/login/view.dart';

import '../../pages/signin/bindings.dart';
import '../../pages/signin/view.dart';
import '../../pages/specialist/specialist_application/bindings.dart';
import '../../pages/specialist/specialist_chat/index.dart';
import '../../pages/specialist/specialist_report_kanban/index.dart';
import '../../pages/specialist/specialist_report_kanban/view.dart';
import '../../pages/specialist/specialist_report_menagment/index.dart';
import '../../pages/student/application/index.dart';
import '../../pages/student/chat/index.dart';
import '../../pages/student/messages/index.dart';
import '../../pages/student/profile/index.dart';
import '../../pages/student/profile/view.dart';
import '../../pages/student/report_form/index.dart';
import '../../pages/welcome/index.dart';
import '../middlewares/router_welcome.dart';

class AppPages {
  static const INITIAL = AppRoutes.INITIAL;
  static const Application = AppRoutes.Application;
  static final RouteObserver<Route> observer = RouteObserver();
  static List<String> history = [];

  static final List<GetPage> routes = [
    GetPage(
        name: AppRoutes.INITIAL,
        page: () => const WelcomePage(),
        binding: WelcomeBinding(),
        middlewares: [RouteWelcomeMiddleware(priority: 1)]),
    GetPage(
      name: AppRoutes.Login,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.Application,
      page: () => ApplicationPage(),
      binding: ApplicationBinding(),
    ),
    GetPage(
      name: AppRoutes.AdminApplication,
      page: () => SigninPage(),
      binding: SiginBinding(),
    ),
    GetPage(
      name: AppRoutes.SpecialistApplication,
      page: () => SpecialistApplicationPage(),
      binding: SpecialistApplicationBinding(),
    ),
    GetPage(
      name: AppRoutes.Messages,
      page: () => MessagePage(),
      binding: MessagesBinding(),
    ),
    GetPage(
      name: AppRoutes.Chat,
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 200),
      page: () => ChatPage(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: AppRoutes.SpecialistChat,
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 200),
      page: () => SpecialistChatPage(),
      binding: SpecialistChatBinding(),
    ),
    GetPage(
      name: AppRoutes.ReportForm,
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 200),
      page: () => ReportFormPage(),
      binding: ReportFormBinding(),
    ),
    GetPage(
      name: AppRoutes.SpecialistReportMenagment,
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 200),
      page: () => SpecialistReportsMenagmentPage(),
      binding: SpecialistReportMenagmentBinding(),
    ),
    GetPage(
      name: AppRoutes.SpecialistReportCanban,
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 200),
      page: () => const SpecialistReportKanbanPage(),
      binding: SpecialistReportMenagmentBinding(),
    ),
    GetPage(
      name: AppRoutes.YourReportInfoPage,
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 200),
      page: () => YourReportInfoPage(),
      binding: YourReportInfoBinding(),
    ),
    GetPage(
      name: AppRoutes.Profile,
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 200),
      page: () => ProfilePage(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.SpecialistProfile,
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 200),
      page: () => SpecialistProfilePage(),
      binding: SpecialistProfileBinding(),
    ),

    GetPage(
      name: AppRoutes.Settings,
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 200),
      page: () => SettingsPage(),
      binding: SettingsBindings(),
    )
  ];
}
