import 'package:intl/intl.dart';

String fullDateFormat(DateTime dt){
  final dtFormat = new DateFormat('dd.MM.yyyy');
  return dtFormat.format(dt);
}
String duTimeLineFormat(DateTime dt) {
  var now = DateTime.now();
  var difference = now.difference(dt);
  if(difference.inHours>24){
    final dtFormat = new DateFormat('HH:mm dd.MM');
    return dtFormat.format(dt);
  }
  final dtFormat = new DateFormat.Hm();
  return dtFormat.format(dt);
 /*
  var now = DateTime.now();
  var difference = now.difference(dt);
  if (difference.inMinutes < 60) {
    return "${difference.inMinutes} m ago";
  }
  if (difference.inHours < 24) {
    return "${difference.inHours} h ago";
  }

  else if (difference.inDays < 30) {
    return "${difference.inDays} d ago";
  }
  // MM-dd
  else if (difference.inDays < 365) {
    final dtFormat = new DateFormat('MM-dd');
    return dtFormat.format(dt);
  }
  // yyyy-MM-dd
  else {
    final dtFormat = new DateFormat('yyyy-MM-dd');
    var str = dtFormat.format(dt);
    return str;
  }*/
}