import 'package:ecommercefood/modules/components/NavBar.dart';
import 'package:ecommercefood/modules/controller/state_controller.dart';
import 'package:ecommercefood/modules/components/CardProduct.dart';
import 'package:ecommercefood/modules/components/ListProducts.dart';
import 'package:ecommercefood/modules/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Product> listProducts = [];

  

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const paddingSafeArea = 20.0;
    final widthSafeArea = size.width - (paddingSafeArea * 2);
    
    final provider = Provider.of<StateController>(context);
    listProducts = provider.getFavoriteProducts();

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
