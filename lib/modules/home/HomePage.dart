import 'package:ecommercefood/data/database.dart';
import 'package:ecommercefood/modules/NavBar/NavBar.dart';
import 'package:ecommercefood/modules/controller/state_controller.dart';
import 'package:ecommercefood/modules/home/CardProduct.dart';
import 'package:ecommercefood/modules/home/botton_navigation_bar.dart';
import 'package:ecommercefood/modules/home/categories_menu.dart';
import 'package:ecommercefood/modules/home/products_list.dart';
import 'package:ecommercefood/modules/models/Category.dart';
import 'package:ecommercefood/modules/models/Product.dart';
import 'package:ecommercefood/shared/themes/app_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> listProducts = [];
  List<Category> listCategories = [];

  int idSelectedCategory = 1;

  List<Product> filterProducts(int idCategory, BuildContext context) {
    final provider = Provider.of<StateController>(context);
    return provider.listProducts
        .where((product) => product.categoryId == idCategory)
        .toList();
  }

  @override
  void initState() {
    super.initState();
    listCategories = DatabaseProducts.listCategories;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const paddingSafeArea = 20.0;
    final widthSafeArea = size.width - (paddingSafeArea * 2);
    listProducts = filterProducts(idSelectedCategory, context);
    return Scaffold(
      appBar: const NavBar(),
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
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Transform.scale(
                  scale: 0.8,
                  child: Image.asset(AppImages.delivery)),
              ],
            ),
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
            // const SizedBox(height: 5),
            Expanded(
              child: listProducts.isNotEmpty
                  ? ProductsList(
                      paddingSafeArea: paddingSafeArea,
                      widthSafeArea: widthSafeArea,
                  )
                  : Container(),
            )
          ]),
        ),
      ),
      bottomNavigationBar: const MenuBar(),
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
