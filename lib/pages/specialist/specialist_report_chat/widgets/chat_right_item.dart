import 'package:flutter/material.dart';

import '../../../../Utils/date.dart';
import '../../../../entities/msg_content.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget ChatRightItem(Msgcontent item) {
  return Container(
    padding: EdgeInsets.only(top: 10.w, left: 15.w, right: 15.w, bottom: 10.w),
    child: Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
                child: Container(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(item.sender ?? "Nie ma"),
                    ))),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 230.w, minHeight: 40.w),
              child: Container(
                  margin: EdgeInsets.only(right: 10.w, top: 0.w),
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.only(topLeft:Radius.circular(10.w),topRight: const Radius.circular(0),bottomLeft:Radius.circular(10.w),bottomRight: Radius.circular(10.w) ),
                  ),
                  child: item.type == "text"
                      ? Text(
                          "${item.content}",
                          style: TextStyle(color: Colors.white),
                        )
                      : ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 230.w,
                            minWidth: 40.w,
                          ),
                          child: GestureDetector(
                            onTap: () {},
                            child: CachedNetworkImage(
                              imageUrl: "${item.content}",
                            ),
                          ),
                        )),
            ),
          ],
        ),
        Container(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              duTimeLineFormat(
                item.addtime!.toDate(),
              ),
              overflow: TextOverflow.clip,
              maxLines: 1,
            ),
          ),
        )
      ],
    ),
  );
}
