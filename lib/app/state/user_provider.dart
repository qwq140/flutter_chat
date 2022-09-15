import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/app/data/user_model.dart';
import 'package:flutter_chat/app/repo/user_service.dart';

class UserProvider extends ChangeNotifier {

  User? _user;
  UserModel? _userModel;

  UserProvider() {
    initUser();
  }

  /// FirebaseAuth 인증상태변화를 감지해서 firestore db에 사용자 정보 저장
  void initUser() {
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      await setUser(user);
      notifyListeners();
    });
  }

  Future setUser(User? user) async {
    if (user == null) {
      print('로그아웃?');
      _userModel = null;
      _user = null;
      return;
    }
    _user = user;

    UserModel userModel = UserModel(
      userKey: user.uid,
      email: user.email ?? "",
      username: user.displayName ?? "",
      profileUrl: user.photoURL,
      createdDate: DateTime.now(),
    );

    await UserService().createNewUser(userModel);
    _userModel = await UserService().getUserInfo(user.uid);
  }

  UserModel? get userModel => _userModel;

  User? get user => _user;

  bool get isLogin => _userModel != null;
}
