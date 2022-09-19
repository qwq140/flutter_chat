import 'package:flutter/material.dart';
import 'package:flutter_chat/app/data/chat_model.dart';
import 'package:flutter_chat/app/data/chatroom_model.dart';
import 'package:flutter_chat/app/repo/chat_service.dart';

class ChatProvider extends ChangeNotifier {

  final String _chatroomKey;
  ChatroomModel? _chatroomModel;
  final List<ChatModel> _chatList = [];

  ChatProvider(this._chatroomKey){
    ChatService().connectChatroom(_chatroomKey).listen((chatroomModel) {
      print('dskjfdk');
      _chatroomModel = chatroomModel;
      if(_chatList.isEmpty){
        ChatService().getChatList(_chatroomKey).then((chatList){
          _chatList.addAll(chatList);
          notifyListeners();
        });
      } else {
        if(_chatList.first.reference == null) _chatList.removeAt(0);
        ChatService().getLatestChatList(_chatroomKey, _chatList.first.reference!).then((chatList){
          _chatList.insertAll(0, chatList);
          notifyListeners();
        });
      }
    });
  }

  Future sendChat(String userKey, String msg) async {
    ChatModel chatModel = ChatModel(userKey: userKey, msg: msg, createdDate: DateTime.now());

    // 임시로 화면에 보여줌
    _chatList.insert(0, chatModel);
    notifyListeners();

    await ChatService().createNewChat(chatModel, _chatroomKey);
  }

  List<ChatModel> get chatList => _chatList;

  ChatroomModel? get chatroomModel => _chatroomModel;

  String get chatroomKey => _chatroomKey;
}