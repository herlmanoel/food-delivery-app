import 'package:ecommercefood/src/modules/components/FormProduct.dart';
import 'package:ecommercefood/src/modules/pages/FavoritePage.dart';
import 'package:ecommercefood/src/modules/pages/HomePage.dart';
import 'package:ecommercefood/src/modules/pages/LoginPage.dart';
import 'package:ecommercefood/src/modules/pages/ProductPage.dart';
import 'package:ecommercefood/src/modules/pages/SplashPage.dart';
import 'package:ecommercefood/src/modules/pages/UserPage.dart';
import 'package:flutter/material.dart';

class Routes {
  static const SPLASH = '/splash';
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const FAVORITES = '/favorites';
  static const FORM_PRODUCT = '/form-product';
  static const PRODUCT_PAGE = '/product-page';
  static const USER_PAGE = '/user-page';

  static Map<String, Widget Function(BuildContext)> routes = {
    SPLASH: (context) => SplashPage(),
    HOME: (context) => const HomePage(),
    LOGIN: (context) => const LoginPage(),
    FAVORITES: (context) => const FavoritesPage(),
    FORM_PRODUCT: (context) => const FormProduct(),
    PRODUCT_PAGE: (context) => ProductPage(),
    USER_PAGE: (context) => UserPage(),
  };
}
