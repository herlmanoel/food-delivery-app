import 'package:ecommercefood/data/database.dart';
import 'package:ecommercefood/modules/NavBar/NavBar.dart';
import 'package:ecommercefood/modules/home/CardProduct.dart';
import 'package:ecommercefood/modules/home/products_list.dart';
import 'package:ecommercefood/modules/models/Product.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Product> listProducts = [];

  List<Product> products() {
    return DatabaseProducts.listProductsData
      .where((product) => product.isFavorite == true)
      .toList();
  }

  @override
  void initState() {
    super.initState();
    listProducts = products();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const paddingSafeArea = 20.0;
    final widthSafeArea = size.width - (paddingSafeArea * 2);
    listProducts = products();
    return Scaffold(
      appBar: const NavBar(),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: paddingSafeArea),
          child: Column(children: [
            // const SizedBox(height: 5),
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
}
