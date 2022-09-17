import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<List<ChatroomModel>> getAllChatList(String userKey) async {
    print('dsdsds');
    List<ChatroomModel> chatroomList = [];

    QuerySnapshot<Map<String, dynamic>> chatroomSnapshot = await FirebaseFirestore.instance.collection('chatrooms').get();
    print('dsdskjddsjkh');

    for (var documentSnapshot in chatroomSnapshot.docs) {
      print('fsdkfdsjkf');
      print(documentSnapshot.data());

      chatroomList.add(ChatroomModel.fromQuerySnapshot(documentSnapshot));
      print('dsdjskdsh');
    }

    print(chatroomList);

    return chatroomList;
  }
}