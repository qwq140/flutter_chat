import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat/app/data/chat_model.dart';
import 'package:flutter_chat/app/data/chatroom_model.dart';

class ChatService {
  static final ChatService _instance = ChatService._internal();

  factory ChatService() => _instance;

  ChatService._internal();

  Future createNewChatroom(ChatroomModel chatroom) async {
    DocumentReference<Map<String, dynamic>> documentReference = FirebaseFirestore.instance.collection('chatrooms').doc(chatroom.chatroomKey);

    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await documentReference.get();

    if(!documentSnapshot.exists){
      await documentReference.set(chatroom.toJson());
    }
  }

  Future<List<ChatroomModel>> getChatroomList(String userKey) async {
    List<ChatroomModel> chatroomList = [];

    QuerySnapshot<Map<String, dynamic>> chatroomSnapshot = await FirebaseFirestore.instance.collection('chatrooms').get();

    for (var documentSnapshot in chatroomSnapshot.docs) {
      chatroomList.add(ChatroomModel.fromQuerySnapshot(documentSnapshot));
    }

    return chatroomList;
  }

  Future createNewChat(ChatModel chatModel, String chatroomKey) async {
    DocumentReference<Map<String, dynamic>> chatDocRef = FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(chatroomKey)
        .collection('chats')
        .doc();

    DocumentReference<Map<String, dynamic>> chatroomDocRef = FirebaseFirestore.instance.collection('chatrooms').doc(chatroomKey);

    // chatroom의 lastMsg, lastMsgDate, lastMsgUserKey 갱신하기
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(chatDocRef, chatModel.toJson());
      transaction.update(chatroomDocRef, {
        'lastMsg': chatModel.msg,
        'lastMsgDate': chatModel.createdDate,
        'lastMsgUserKey': chatModel.userKey,
      });
    });
  }

  // 채팅방 정보 조회 (스트림으로 계속 받기)
  Stream<ChatroomModel> connectChatroom(String chatroomKey) {
    return FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(chatroomKey)
        .snapshots()
        .transform(snapshotToChatroom);
  }

  // stream 사용시 주어진 값으로 가공할때 사용
  // firebase를 사용할 때 받는값은 DocumentSnapshot
  // DocumentSnapshot을 ChatroomModel로 가공
  var snapshotToChatroom = StreamTransformer<DocumentSnapshot<Map<String, dynamic>>, ChatroomModel>.fromHandlers(
    handleData: (data, sink) {
      ChatroomModel chatroomModel = ChatroomModel.fromSnapshot(data);
      sink.add(chatroomModel);
    },
  );

  // 채팅룸 첫 로딩시에 최신순으로 채팅 10개 조회
  Future<List<ChatModel>> getChatList(String chatroomKey) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('chatrooms')
        .doc(chatroomKey)
        .collection('chats')
        .orderBy('createdDate', descending: true)
        .limit(10)
        .get();

    List<ChatModel> chatList = [];

    for (var docSnapshot in snapshot.docs) {
      ChatModel chatModel = ChatModel.fromQuerySnapshot(docSnapshot);
      chatList.add(chatModel);
    }
    return chatList;
  }

  // 화면상의 최신 채팅을 기준으로 최신 채팅 가져오기
  Future<List<ChatModel>> getLatestChatList(String chatroomKey, DocumentReference currentLatestChatRef) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('chatrooms')
        .doc(chatroomKey)
        .collection('chats')
        .orderBy('createdDate', descending: true)
        .endBeforeDocument(await currentLatestChatRef.get())
        .get();

    List<ChatModel> chatList = [];

    for (var docSnapshot in snapshot.docs) {
      ChatModel chatModel = ChatModel.fromQuerySnapshot(docSnapshot);
      chatList.add(chatModel);
    }
    return chatList;
  }
}