import 'package:ecommercefood/modules/controller/state_controller.dart';
import 'package:flutter/material.dart';
import 'package:ecommercefood/modules/models/Product.dart';
import 'package:provider/provider.dart';
import '../../../shared/themes/app_colors.dart';
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

  void atualizarList() {
    final provider = Provider.of<StateController>(context);
    listProducts = provider.getProductsShopping();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const paddingSafeArea = 20.0;
    final widthSafeArea = size.width - (paddingSafeArea * 2);
    final provider = Provider.of<StateController>(context);
    listProducts = provider.getProductsShopping();

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
            Column(
              children: [
                Text("Preço total: ${provider.shoppingCart.total}", style: const TextStyle(fontSize: 16),),
                Text("Tipos de produtos: ${provider.shoppingCart.totalItens}", style: const TextStyle(fontSize: 16),),
              ],
            ),
            Expanded(child: listProducts.isNotEmpty
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, i) =>
                      CardCart(widthFather: widthSafeArea, product: listProducts[i], provider: provider),
                    itemCount: listProducts.length,
                  )
                : Container(),
            )
          ],
        ),
    ));
  }
}