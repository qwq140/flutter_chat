import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/app/data/chatroom_model.dart';
import 'package:flutter_chat/app/data/user_model.dart';
import 'package:flutter_chat/app/repo/chat_service.dart';

class ChatroomListProvider extends ChangeNotifier {

  List<ChatroomModel> chatroomList = [];

  final _chatroomController = StreamController<List<ChatroomModel>>.broadcast();

  get chatroomStream => _chatroomController.stream;

  get addChatroom => _chatroomController.sink.add(chatroomList);

  ChatroomListProvider(){
    ChatService().connectChatroomList().listen((snapshot) {
      chatroomList.clear();
      for (var docSnapshot in snapshot.docs) {
        ChatroomModel chatroomModel = ChatroomModel.fromQuerySnapshot(docSnapshot);
        chatroomList.add(chatroomModel);
      }
      _chatroomController.sink.add(chatroomList);
    });
  }

  // Future<void> getChatroomList(String userKey) async {
  //   chatroomList = await ChatService().getChatroomList(userKey);
  //   notifyListeners();
  // }

  Future joinChatroom(String userKey, String chatroomKey) async {
    await ChatService().joinChatroom(chatroomKey, userKey);
  }

}