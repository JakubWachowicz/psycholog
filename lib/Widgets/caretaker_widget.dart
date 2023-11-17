import 'package:jw_projekt/Widgets/user_avatar.dart';

import '../entities/user.dart';
import 'package:flutter/material.dart';
 buildCaretakerWidget(UserData user)  {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(right: 8,top: 8),
        child: UserAvatarWidget(
            role: "specialis", path: user.photourl!, size: 46),
      ),
      Text(user.name!)
    ],
  );
}