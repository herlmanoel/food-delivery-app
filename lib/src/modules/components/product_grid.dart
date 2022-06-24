
import 'package:ecommercefood/src/modules/components/product_item.dart';
import 'package:ecommercefood/src/modules/models/Product.dart';
import 'package:flutter/material.dart';

class ProductGrid extends StatelessWidget {
  List<Product> products = [];
  ProductGrid({ required this.products });
  
  @override
  Widget build(BuildContext context) {

    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ProductItem(
        product: products[i],
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, //2 produtos por linha
        childAspectRatio: 0.75, //diemnsao de cada elemento
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
