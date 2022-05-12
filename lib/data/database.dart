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
        id: 1,
        name: 'Chicken burger',
        description: "200 gr chicken + cheese  Lettuce + tomato",
        image: Image.asset(AppImages.burguerProduct),
        price: 20,
        category: Category(
            id: 1, title: 'Burguer', icon: Image.asset(AppImages.burguerIcon))),
    Product(
        id: 2,
        name: 'Chicken burger',
        description: "200 gr chicken + cheese  Lettuce + tomato",
        image: Image.asset(AppImages.burguerProduct),
        price: 30,
        category: Category(
            id: 1, title: 'Burguer', icon: Image.asset(AppImages.burguerIcon))),
    Product(
        id: 3,
        name: 'Chicken burger',
        description: "200 gr chicken + cheese  Lettuce + tomato",
        image: Image.asset(AppImages.burguerProduct),
        price: 40,
        category: Category(
            id: 1, title: 'Burguer', icon: Image.asset(AppImages.burguerIcon))),
    Product(
        id: 4,
        name: 'Chicken burger',
        description: "200 gr chicken + cheese  Lettuce + tomato",
        image: Image.asset(AppImages.burguerProduct),
        price: 50,
        category: Category(
            id: 1, title: 'Burguer', icon: Image.asset(AppImages.burguerIcon))),
    Product(
        id: 5,
        name: 'Chicken burger',
        description: "200 gr chicken + cheese  Lettuce + tomato",
        image: Image.asset(AppImages.burguerProduct),
        price: 60,
        category: Category(
            id: 1, title: 'Burguer', icon: Image.asset(AppImages.burguerIcon))),
    Product(
        id: 6,
        name: 'Chicken burger',
        description: "200 gr chicken + cheese  Lettuce + tomato",
        image: Image.asset(AppImages.burguerProduct),
        price: 70,
        category: Category(
            id: 1, title: 'Burguer', icon: Image.asset(AppImages.burguerIcon))),
    Product(
        id: 7,
        name: 'Chicken burger',
        description: "200 gr chicken + cheese  Lettuce + tomato",
        image: Image.asset(AppImages.burguerProduct),
        price: 80,
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