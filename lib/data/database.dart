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

  static List<Category> getListCategoriesOrderByTitle() {
    return listCategories.toList()..sort((a, b) => a.title.compareTo(b.title));
  }

  static List<Product> listProductsData = [];

  static putProduct(Product product) {
    int indexProduct =
        listProductsData.indexWhere((element) => element.id == product.id);
    listProductsData[indexProduct] = product;
  }

  static getFavoriteProducts() {
    return listProductsData.where((element) => element.isFavorite).toList();
  }
}
