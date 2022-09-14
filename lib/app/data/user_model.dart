import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String userKey;
  late String email;
  late String username;
  String? profileUrl;
  late DateTime createdDate;
  DocumentReference? reference;

  UserModel({
    required this.userKey,
    required this.email,
    required this.username,
    this.profileUrl,
    required this.createdDate,
    this.reference,
  });

  UserModel.fromJson(Map<String, dynamic> json, this.userKey, this.reference) {
    email = json['email'];
    username = json['username'];
    profileUrl = json['profileUrl'];
    createdDate = json['createdDate'] == null ? DateTime.now() : (json['createdDate'] as Timestamp).toDate();
  }

  // : 이니셜라이져
  UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) : this.fromJson(snapshot.data()!, snapshot.id, snapshot.reference);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['username'] = username;
    map['profileUrl'] = profileUrl;
    map['createdDate'] = createdDate;
    return map;
  }
}
