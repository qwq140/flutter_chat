import 'package:flutter/material.dart';
import 'package:flutter_chat/app/screens/auth/login_screen.dart';
import 'package:flutter_chat/app/screens/chat/chat_list_screen.dart';
import 'package:flutter_chat/app/state/user_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final UserProvider userProvider = UserProvider();

final GoRouter _router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) => const ChatListScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) => const LoginScreen(),
    ),
  ],
  refreshListenable: userProvider,
  redirect: (state) {
    final isLogin = userProvider.isLogin;
    final loggingIn = state.subloc == '/login';
    if (!isLogin) return loggingIn ? null : '/login';

    if (loggingIn) return '/';

    return null;
  }

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