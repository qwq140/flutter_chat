import 'package:flutter/material.dart';
import 'package:flutter_chat/app/screens/auth/login_screen.dart';
import 'package:flutter_chat/app/state/user_provider.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    UserProvider userProvider = UserProvider();
    return ChangeNotifierProvider<UserProvider>(
      create: (context) {
        return userProvider;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Spoqa',
        ),
        home: LoginScreen(),
      ),
    );
  }
}
