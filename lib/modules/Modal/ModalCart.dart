import 'package:ecommercefood/data/database.dart';
import 'package:flutter/material.dart';
import 'package:ecommercefood/modules/models/Product.dart';
import '../../shared/themes/app_colors.dart';
import 'CardCart.dart';

class ModalCart extends StatefulWidget implements PreferredSizeWidget {
  const ModalCart({Key? key}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(50);
  @override
  State<ModalCart> createState() => _CartModalState();
}

class _CartModalState extends State<ModalCart>{
  List<Product> listProducts = [];

  List<Product> products() {
    return DatabaseProducts.listProductsData
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
    return Expanded(child: Container(
      color: AppColors.stroke,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            Expanded(child: listProducts.isNotEmpty
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, i) =>
                      CardCart(widthFather: widthSafeArea, product: listProducts[i]),
                    itemCount: listProducts.length,
                  )
                : Container(),
            )
          ],
        ),
    ));
  }
}