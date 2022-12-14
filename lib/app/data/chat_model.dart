import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ChatModel {
  late String chatKey;
  late String userKey;
  late String msg;
  late String username;
  String? profileUrl;
  late DateTime createdDate;
  DocumentReference? reference;

  ChatModel({
    required this.userKey,
    required this.msg,
    required this.username,
    this.profileUrl,
    required this.createdDate,
    this.reference,
  });

  ChatModel.fromJson(Map<String, dynamic> json, this.chatKey, this.reference){
    userKey = json['userKey'] ?? "";
    msg = json['msg'] ?? "";
    username = json['username'] ?? "";
    profileUrl = json['profileUrl'];
    createdDate = json['createdDate'] == null ? DateTime.now() : (json['createdDate'] as Timestamp).toDate();
  }

  Map<String, dynamic> toJson(){
    final map = <String, dynamic>{};
    map['userKey'] = userKey;
    map['msg'] = msg;
    map['username'] = username;
    map['profileUrl'] = profileUrl;
    map['createdDate'] = createdDate;
    return map;
  }

  ChatModel.fromSnapshot(DocumentSnapshot snapshot) : this.fromJson(snapshot.data()! as Map<String, dynamic>, snapshot.id, snapshot.reference);

  ChatModel.fromQuerySnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) : this.fromJson(snapshot.data(), snapshot.id, snapshot.reference);
}
