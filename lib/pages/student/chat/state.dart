import 'package:get/get.dart';

import '../../../entities/msg_content.dart';

class ChatState{

  RxList<Msgcontent> msgcontentList = <Msgcontent>[].obs;
  var specialist_uid="".obs;
  var specialist_name="".obs;
  var specialist_avatar = "".obs;
  late final student_name = "".obs;
}