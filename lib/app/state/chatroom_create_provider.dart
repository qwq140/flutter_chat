import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_chat/app/data/chatroom_model.dart';
import 'package:flutter_chat/app/data/user_model.dart';
import 'package:flutter_chat/app/repo/chat_service.dart';
import 'package:flutter_chat/app/repo/file_service.dart';
import 'package:intl/intl.dart';

class ChatroomCreateProvider extends ChangeNotifier {

  String? _title;
  String? _intro;
  Uint8List? _img;

  String? get title => _title;

  set title(String? value) {
    _title = value;
  }

  String? get intro => _intro;

  set intro(String? value) {
    _intro = value;
  }

  Uint8List? get img => _img;

  set img(Uint8List? value) {
    _img = value;
    notifyListeners();
  }

  bool validate() {
    if (title == null || title!.isEmpty) {
      return false;
    }
    return true;
  }

  Future submit(String userKey) async {
    String formatDate = DateFormat('yyyyMMddHHmm').format(DateTime.now());
    String chatroomKey = 'CHATROOM_$formatDate$userKey';

    String? downloadImageUrl;

    if(img != null){
       downloadImageUrl = await FileService.uploadImage(img!, chatroomKey);
    }

    ChatroomModel chatroomModel = ChatroomModel(
      chatroomKey: chatroomKey,
      imageUrl: downloadImageUrl,
      hostKey: userKey,
      createdDate: DateTime.now(),
      lastMsgDate: DateTime.now(),
      title: title ?? "",
      intro: intro,
      userKeys: [userKey],
    );

    await ChatService().createNewChatroom(chatroomModel);
  }
}