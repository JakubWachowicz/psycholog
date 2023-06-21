import 'package:get/get.dart';

import '../../../entities/msg_content.dart';

class SpecialistChatState{

  RxList<Msgcontent> msgcontentList = <Msgcontent>[].obs;
  var to_uid="".obs;
  var to_name="".obs;
  var to_avatar = "".obs;
  late final from_name = "".obs;
  var from_uid = "".obs;


}