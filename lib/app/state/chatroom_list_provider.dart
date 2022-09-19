import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/app/data/chatroom_model.dart';
import 'package:flutter_chat/app/repo/chat_service.dart';

class ChatroomListProvider extends ChangeNotifier {

  List<ChatroomModel> chatroomList = [];

  Future<void> getChatroomList(String userKey) async {
    chatroomList = await ChatService().getChatroomList(userKey);
    notifyListeners();
  }

}