import 'package:ecommercefood/modules/models/Product.dart';
import 'package:ecommercefood/modules/models/ShoppingCart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'CardProduct.dart';

class ProductsList extends StatelessWidget {
  double paddingSafeArea;
  double widthSafeArea;
  List<Product> listProducts;
  ProductsList(
      {required this.listProducts,
      required this.paddingSafeArea,
      required this.widthSafeArea,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShoppingCart>(context);
    final products = provider.getProducts();
    
    return GridView.builder(
      padding: EdgeInsets.symmetric(vertical: paddingSafeArea),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 0.68,
      ),
      itemBuilder: (context, i) => ChangeNotifierProvider.value(
        value: products[i],
        child:
            CardProduct(widthFather: widthSafeArea, product: listProducts[i]),
      ),
      itemCount: products.length,
    );
  }
}
