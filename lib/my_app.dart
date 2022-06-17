import 'package:ecommercefood/modules/controller/state_controller.dart';
import 'package:ecommercefood/modules/pages/FavoritePage.dart';
import 'package:ecommercefood/modules/components/FormProduct.dart';
import 'package:ecommercefood/modules/pages/LoginPage.dart';
import 'package:ecommercefood/modules/pages/ProductPage.dart';
import 'package:ecommercefood/modules/pages/SplashPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'modules/pages/HomePage.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StateController>(context);
    
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
        '/form-product': (context) => const FormProduct(),
        '/product-page': (context) => ProductPage(),
      },
    );
  }
}
