import 'package:ecommercefood/src/data/database.dart';
import 'package:ecommercefood/src/modules/components/cart/ModalCart.dart';
import 'package:ecommercefood/src/modules/components/product_grid.dart';
import 'package:ecommercefood/src/modules/controller/state_controller.dart';
import 'package:ecommercefood/src/modules/components/CardProduct.dart';
import 'package:ecommercefood/src/modules/components/NavBotton.dart';
import 'package:ecommercefood/src/modules/components/MenuCategories.dart';
import 'package:ecommercefood/src/modules/models/Category.dart';
import 'package:ecommercefood/src/modules/models/Product.dart';
import 'package:ecommercefood/src/modules/pages/FavoritePage.dart';
import 'package:ecommercefood/src/shared/themes/app_colors.dart';
import 'package:ecommercefood/src/shared/themes/app_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pages/SettingsPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> listProducts = [];
  List<Category> listCategories = [];
  bool _isIconShoppingCartSelected = false;

  int idSelectedCategory = 3;

  List<Product> filterProducts(int idCategory, BuildContext context) {
    final provider = Provider.of<StateController>(context);
    return provider
        .getProducts()
        .where((product) => product.categoryId == idCategory)
        .toList();
  }

  @override
  void initState() {
    super.initState();
    listCategories = DatabaseProducts.listCategories;
  }
  void toggleIconShoppingCart() {
    setState(() {
      _isIconShoppingCartSelected = !_isIconShoppingCartSelected;
    });
  }

  void toFavorites(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FavoritesPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    const paddingSafeArea = 20.0;
    listProducts = filterProducts(idSelectedCategory, context);
    const SettingsPage().build(context);
    return Scaffold(
      // appBar: const NavBar(),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: paddingSafeArea),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Transform.scale(
                      scale: 0.6,
                      child: Image.asset(AppImages.delivery),
                    ),
                    const Text(
                      'Order Your Food\nFast and Free',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                _iconFavoriteAndShopping(context),
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
                  return MenuCategories(
                    category: category,
                    setState: setState,
                    listCategories: listCategories,
                    setIdSelectCategory: setIdSelectCategory,
                  );
                },
              ),
            ),
            ProductGrid(products: listProducts),
          ]),
        ),
      ),
      bottomNavigationBar: const NavBotton(),
    );
  }

  Row _iconFavoriteAndShopping(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.favorite_outline),
          tooltip: 'Show Snackbar',
          onPressed: () => toFavorites(context),
        ),
        IconButton(
          icon: Icon(Icons.shopping_cart_outlined,
              color: _isIconShoppingCartSelected
                  ? AppColors.backgroundSplash
                  : Colors.black),
          tooltip: 'Go to the next page',
          onPressed: () {
            toggleIconShoppingCart();
            showModalBottomSheet<void>(
              backgroundColor: Colors.transparent,
              context: context,
              builder: (BuildContext context) {
                return const ModalCart();
              },
            ).whenComplete(() =>  toggleIconShoppingCart());
          },
        ),
      ],
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
