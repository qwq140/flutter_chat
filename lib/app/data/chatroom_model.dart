import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ChatroomModel {
  late String chatroomKey;
  String? imageUrl;
  late String hostKey;
  late DateTime createdDate;
  late String lastMsg;
  late DateTime lastMsgDate;
  late String lastMsgUserKey;
  late String title;
  String? intro;
  late List<String> userKeys;
  DocumentReference? reference;

  ChatroomModel({
    required this.chatroomKey,
    this.imageUrl,
    required this.hostKey,
    required this.createdDate,
    this.lastMsg = "",
    required this.lastMsgDate,
    this.lastMsgUserKey = "",
    required this.title,
    this.intro,
    required this.userKeys,
    this.reference,
  });

  ChatroomModel.fromJson(Map<String, dynamic> json, this.chatroomKey, this.reference) {
    imageUrl = json['imageUrl'];
    hostKey = json['hostKey'] ?? "";
    createdDate = json['createdDate'] == null ? DateTime.now() : (json['createdDate'] as Timestamp).toDate();
    lastMsg = json['lastMsg'] ?? "";
    lastMsgDate = json['lastMsgDate'] == null ? DateTime.now() : (json['lastMsgDate'] as Timestamp).toDate();
    lastMsgUserKey = json['lastMsgUserKey'] ?? "";
    title = json['title'] ?? "";
    intro = json['intro'];
    userKeys =  json['userKeys'] != null ? json['userKeys'].cast<String>() : [];
  }

  // : 이니셜라이져
  ChatroomModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) : this.fromJson(snapshot.data()!, snapshot.id, snapshot.reference);
  ChatroomModel.fromQuerySnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) : this.fromJson(snapshot.data(), snapshot.id, snapshot.reference);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['imageUrl'] = imageUrl;
    map['hostKey'] = hostKey;
    map['createdDate'] = createdDate;
    map['lastMsg'] = lastMsg;
    map['lastMsgDate'] = lastMsgDate;
    map['lastMsgUserKey'] = lastMsgUserKey;
    map['title'] = title;
    map['intro'] = intro;
    map['userKeys'] = userKeys;
    return map;
  }
}
