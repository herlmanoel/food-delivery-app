import 'package:ecommercefood/modules/home/ProductPage.dart';
import 'package:ecommercefood/modules/models/Product.dart';
import 'package:ecommercefood/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

class CardProduct extends StatefulWidget {
  double widthFather;
  Product product;
  CardProduct({required this.widthFather, required this.product, Key? key});

  @override
  State<CardProduct> createState() => _CardProductState(widthFather, product);
}

class _CardProductState extends State<CardProduct> {
  double widthFather;
  Product product;
  _CardProductState(this.widthFather, this.product);

  @override
  Widget build(BuildContext context) {
    final double _large = ((widthFather - 40) / 2);
    return Container(
      padding: EdgeInsets.all(_large * 0.05),
      width: _large,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.9),
            blurRadius: 10,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.star_rate,
                color: Colors.yellow,
              ),
              Text(
                "${product.starts}",
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Image.asset(AppImages.burguerProduct),
          product.image,
          const SizedBox(height: 10),
          SizedBox(
              child: Text(product.name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold))),
          const SizedBox(height: 10),
          SizedBox(
              child: Text(product.description,
                  style: const TextStyle(
                    fontSize: 14,
                  ))),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                product.getPriceFormat(),
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.backgroundSplash),
              ),
              Container(
                width: 35,
                height: 35,
                // padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.backgroundSplash,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductPage(product: product)),
                    );
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
