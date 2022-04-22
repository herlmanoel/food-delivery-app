import 'package:ecommercefood/modules/home/CardProduct.dart';
import 'package:ecommercefood/modules/home/categories_menu.dart';
import 'package:ecommercefood/modules/home/products_list.dart';
import 'package:ecommercefood/modules/home/search.dart';
import 'package:ecommercefood/modules/models/Category.dart';
import 'package:ecommercefood/modules/models/Product.dart';
import 'package:ecommercefood/shared/themes/app_colors.dart';
import 'package:ecommercefood/shared/themes/app_image.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var listCategories = [
    Category(
        id: 1,
        title: 'Sandwich',
        icon: Image.asset(AppImages.hotDogIcon),
        selected: true),
    Category(id: 2, title: 'Pizza', icon: Image.asset(AppImages.pizzaIcon)),
    Category(id: 3, title: 'Burguer', icon: Image.asset(AppImages.burguerIcon)),
  ];

  List<Product> listProductsData = [
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

  List<Product> listProducts = [];

  int idSelectedCategory = 1;
  
  List<Product> filterProducts(int idCategory) {
    return listProductsData
        .where((product) => product.category.id == idCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const paddingSafeArea = 20.0;
    final widthSafeArea = size.width - (paddingSafeArea * 2);
    listProducts = filterProducts(idSelectedCategory);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: paddingSafeArea),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Order Your Food\nFast and Free',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Image.asset(AppImages.delivery),
              ],
            ),
            const SizedBox(height: 20),
            Search(size: size),
            const SizedBox(height: 20),
            SizedBox(
              width: widthSafeArea,
              child: const Text(
                "Categories",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: listCategories.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  Category category = listCategories[index];
                  // return buttonCategory(category);
                  return CategoriesMenu(
                    category: category,
                    setState: setState,
                    listCategories: listCategories,
                    setIdSelectCategory: setIdSelectCategory,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: listProducts.isNotEmpty
                  ? ProductsList(
                      paddingSafeArea: paddingSafeArea,
                      widthSafeArea: widthSafeArea,
                      listProducts: listProducts)
                  : Container(),
            )
          ]),
        ),
      ),
    );
  }

  GridView listCard(double paddingSafeArea, double widthSafeArea) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(vertical: paddingSafeArea),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 0.68,
      ),
      itemBuilder: (context, i) =>
          CardProduct(widthFather: widthSafeArea, product: listProducts[i]),
      itemCount: listProducts.length,
    );
  }

  setIdSelectCategory(int id) {
    idSelectedCategory = id;
  }
}


