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

class _CartModalState extends State<ModalCart> {
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

    return Container(
      decoration: _decoration(), 
      width: size.width * 0.5,     
      child: listProducts.isEmpty ? _notContentPage() : _contentPage(widthSafeArea, provider, listProducts),
    );
  }

  BoxDecoration _decoration() {
    return const BoxDecoration(
        color: AppColors.stroke,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      );
  }

  Widget _notContentPage() {
    return const Center(
      child: Text(
        'Nenhum produto adicionado',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _contentPage(var widthSafeArea, var provider, var listProducts) {
    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
        Container(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Subtotal",
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    provider.totalPriceShoppingCartFormat,
                    style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              // text button finalizar compra
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.backgroundSplash,
                ),
                child: TextButton(
                  child: const Text(
                    "Finalizar compra",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
        listProducts.isNotEmpty
            ? ListView.builder(
                padding: const EdgeInsets.all(20),
                scrollDirection: Axis.vertical,
                // itemExtent: 70.0,
                shrinkWrap: true,
                itemBuilder: (context, i) => CardCart(
                    widthFather: widthSafeArea,
                    product: listProducts[i],
                    provider: provider),
                itemCount: listProducts.length,
              )
            : Container()
          ],
        );
  }
}
