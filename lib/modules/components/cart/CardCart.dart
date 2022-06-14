import 'package:ecommercefood/modules/controller/state_controller.dart';
import 'package:ecommercefood/modules/models/Product.dart';
import 'package:ecommercefood/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

class CardCart extends StatefulWidget {
  double widthFather;
  Product product;
  StateController provider;
  CardCart(
      {required this.provider,
      required this.widthFather,
      required this.product,
      Key? key});

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
        margin: EdgeInsets.all(_large * 0.05),
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
              Column(
                children: [
                  SizedBox(
                      child: Text(product.name,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold))),
                  const SizedBox(width: 10),
                  Container(
                    width: 100,
                    height: 100,
                    alignment: Alignment.center,
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.getTotalFormat(),
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.backgroundSplash),
                  ),
                  Container(
                    color: AppColors.foodBackground,
                    child: Row(
                      children: [
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
                              Icons.remove,
                              color: Colors.white,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                if (product.quantity <= 0) {
                                  return;
                                }
                                if (product.quantity > 0) {
                                  product.quantity = product.quantity - 1;
                                }
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 35,
                          child: Center(
                            child: Text(
                              product.quantity.toString(),
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
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
                              setState(() {
                                product.quantity = product.quantity + 1;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
