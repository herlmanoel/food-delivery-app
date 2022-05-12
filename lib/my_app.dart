import 'package:ecommercefood/modules/favorites/FavoritePage.dart';
import 'package:ecommercefood/modules/login/login_page.dart';
import 'package:ecommercefood/modules/splash/splash_page.dart';
import 'package:flutter/material.dart';

import 'modules/home/HomePage.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-commerce Food',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/home',
      routes: {
        '/splash': (context) => SplashPage(),
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/favorites': (context) => const FavoritesPage(),
      },
    );
  }
}
