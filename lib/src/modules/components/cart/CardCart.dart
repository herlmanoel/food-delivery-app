import 'package:ecommercefood/src/modules/controller/state_controller.dart';
import 'package:ecommercefood/src/modules/models/Product.dart';
import 'package:ecommercefood/src/shared/themes/app_colors.dart';
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
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              Container(
                width: 100,
                height: 100,
                alignment: Alignment.center,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      product.getNameResume(),
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    product.getTotalFormat(),
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.backgroundSplash),
                  ),
                ],
              ),
            ],
          ),
          _buttonsIncrementAndDecrement()
        ],
      ),
    );
  }

  Widget _buttonsIncrementAndDecrement() {
    return Transform.scale(
      scale: 0.7,
      child: Container(
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
                  if (product.quantity <= 0) {
                    widget.provider.removeItemShoppingCart(product);
                    return;
                  }
                  setState(() {
                    if (product.quantity > 0) {
                      product.quantity = product.quantity - 1;
                    }
                  });
                  if (product.quantity <= 0) {
                    widget.provider.removeItemShoppingCart(product);
                    return;
                  }
                  widget.provider.notifyListeners();
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
                  widget.provider.notifyListeners();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
