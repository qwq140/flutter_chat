import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/app/const/spoqa.dart';
import 'package:flutter_chat/app/repo/user_service.dart';
import 'package:flutter_chat/app/state/user_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(flex: 157),
          const Text('meet', style: Spoqa.black_s40_w700),
          const Spacer(flex: 207),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: InkWell(
              onTap: () {
                UserService().signInWithGoogle();
                // FirebaseAuth.instance.signOut();
              },
              borderRadius: BorderRadius.circular(30),
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text('GOOGLE 로그인', style: Spoqa.black_s14_w400),
              ),
            ),
          ),
          const Spacer(flex: 104),
        ],
      ),
    );
  }
}
