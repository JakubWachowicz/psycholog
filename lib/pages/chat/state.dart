import 'package:get/get.dart';

import '../../entities/msg_content.dart';
class ChatState{

  RxList<Msgcontent> msgcontentList = <Msgcontent>[].obs;
  var to_uid="".obs;
  var to_name="".obs;
  var to_avatar = "".obs;
  var to_loaction = "".obs;
}