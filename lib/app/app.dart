import 'package:flutter/material.dart';
import 'package:flutter_chat/app/screens/auth/login_screen.dart';
import 'package:flutter_chat/app/screens/chat/chat_list_screen.dart';
import 'package:flutter_chat/app/screens/chat/chatroom_create_screen.dart';
import 'package:flutter_chat/app/screens/chat/chatroom_screen.dart';
import 'package:flutter_chat/app/state/chat_provider.dart';
import 'package:flutter_chat/app/state/chatroom_create_provider.dart';
import 'package:flutter_chat/app/state/chatroom_list_provider.dart';
import 'package:flutter_chat/app/state/user_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final UserProvider userProvider = UserProvider();

final GoRouter _router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      name: 'home',
      path: '/chatroom',
      builder: (BuildContext context, GoRouterState state) => ChangeNotifierProvider<ChatroomListProvider>(
        create: (context) => ChatroomListProvider(),
        child: const ChatListScreen(),
      ),
      routes: [
        GoRoute(
          name: 'create',
          path: 'create',
          builder: (BuildContext context, GoRouterState state) => ChangeNotifierProvider<ChatroomCreateProvider>(
            create: (context) => ChatroomCreateProvider(),
            child: const ChatroomCreateScreen(),
          ),
        ),
        GoRoute(
          name: 'detail',
          path: ':chatroomKey',
          builder: (BuildContext context, GoRouterState state) {
            String chatroomKey = state.params['chatroomKey'] ?? "";
            return ChangeNotifierProvider<ChatProvider>(
              create: (context) => ChatProvider(),
              child: const ChatroomScreen(),
            );
          }
        ),
      ]
    ),
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (BuildContext context, GoRouterState state) => const LoginScreen(),
    ),
  ],
  refreshListenable: userProvider,
  redirect: (state) {
    final isLogin = userProvider.isLogin;
    final loggingIn = state.subloc == state.namedLocation('login');
    if (!isLogin) return loggingIn ? null : state.namedLocation('login');

    if (loggingIn) return state.namedLocation('home');

    return null;
  },
  urlPathStrategy: UrlPathStrategy.path

);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<UserProvider>.value(
      value: userProvider,
      child: MaterialApp.router(
        routeInformationProvider: _router.routeInformationProvider,
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Spoqa',
        ),

      ),
    );
  }
}