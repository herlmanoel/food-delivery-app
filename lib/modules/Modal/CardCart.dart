import 'package:ecommercefood/modules/home/ProductPage.dart';
import 'package:ecommercefood/modules/models/Product.dart';
import 'package:ecommercefood/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

class CardCart extends StatefulWidget {
  double widthFather;
  Product product;
  CardCart({required this.widthFather, required this.product, Key? key});

  @override
  State<CardCart> createState() => _CardCartState(widthFather, product);
}

class _CardCartState extends State<CardCart> {
  double widthFather;
  Product product;
  _CardCartState(this.widthFather, this.product);

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
        child: Expanded(
          child: Row(
            children: <Widget>[
              // Image.asset(AppImages.burguerProduct),
              product.image,
              const SizedBox(height: 10),
              SizedBox(
                  child: Text(product.name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              SizedBox(
                  child: Text(product.description,
                      style: const TextStyle(
                        fontSize: 14,
                      ))),
    
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
                ],
              ),
            ],
          ),
        ));
  }
}
