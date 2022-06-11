import 'dart:math';

import 'package:ecommercefood/modules/models/Product.dart';
import 'package:ecommercefood/shared/themes/app_image.dart';
import 'package:flutter/material.dart';

import '../modules/models/Category.dart';

class DatabaseProducts {
  static List<Category> listCategories = [
    Category(
        id: 1,
        title: 'Sandwich',
        icon: Image.asset(AppImages.hotDogIcon),
        selected: true),
    Category(id: 2, title: 'Pizza', icon: Image.asset(AppImages.pizzaIcon)),
    Category(id: 3, title: 'Burguer', icon: Image.asset(AppImages.burguerIcon)),
  ];

  static List<Product> listProductsData = [
    Product(
        id: 'p1',
        name: 'Chicken burger',
        description: "200 gr chicken + cheese  Lettuce + tomato",
        price: 20,
        imageUrl: 'https://i.pinimg.com/originals/45/eb/98/45eb98c8637d591a1bde451eb1bce941.png',
        category: Category(
            id: 1, title: 'Burguer', icon: Image.asset(AppImages.burguerIcon))),
    Product(
        id: 'p2',
        name: 'Chicken burger',
        description: "200 gr chicken + cheese  Lettuce + tomato",
        price: 30,
        imageUrl: 'https://i.pinimg.com/originals/45/eb/98/45eb98c8637d591a1bde451eb1bce941.png',
        category: Category(
            id: 1, title: 'Burguer', icon: Image.asset(AppImages.burguerIcon))),
    Product(
        id: 'p3',
        name: 'Chicken burger',
        description: "200 gr chicken + cheese  Lettuce + tomato",
        price: 40,
        imageUrl: 'https://i.pinimg.com/originals/45/eb/98/45eb98c8637d591a1bde451eb1bce941.png',
        category: Category(
            id: 1, title: 'Burguer', icon: Image.asset(AppImages.burguerIcon))),
    Product(
        id: 'p4',
        name: 'Chicken burger',
        description: "200 gr chicken + cheese  Lettuce + tomato",
        price: 50,
        imageUrl: 'https://i.pinimg.com/originals/45/eb/98/45eb98c8637d591a1bde451eb1bce941.png',
        category: Category(
            id: 1, title: 'Burguer', icon: Image.asset(AppImages.burguerIcon))),
    Product(
        id: 'p5',
        name: 'Chicken burger',
        description: "200 gr chicken + cheese  Lettuce + tomato",
        price: 60,
        imageUrl: 'https://i.pinimg.com/originals/45/eb/98/45eb98c8637d591a1bde451eb1bce941.png',
        category: Category(
            id: 1, title: 'Burguer', icon: Image.asset(AppImages.burguerIcon))),
    Product(
        id: 'p6',
        name: 'Chicken burger',
        description: "200 gr chicken + cheese  Lettuce + tomato",
        price: 70,
        imageUrl: 'https://i.pinimg.com/originals/45/eb/98/45eb98c8637d591a1bde451eb1bce941.png',
        category: Category(
            id: 1, title: 'Burguer', icon: Image.asset(AppImages.burguerIcon))),
    Product(
        id: 'p7',
        name: 'Chicken burger',
        description: "200 gr chicken + cheese  Lettuce + tomato",
        price: 80,
        imageUrl: 'https://i.pinimg.com/originals/45/eb/98/45eb98c8637d591a1bde451eb1bce941.png',
        category: Category(
            id: 1, title: 'Burguer', icon: Image.asset(AppImages.burguerIcon))),
  ];  

  static putProduct(Product product) {
    int indexProduct = listProductsData.indexWhere((element) => element.id == product.id);
    listProductsData[indexProduct] = product;
  }

  static getFavoriteProducts() {
    return listProductsData.where((element) => element.isFavorite).toList();
  }

}