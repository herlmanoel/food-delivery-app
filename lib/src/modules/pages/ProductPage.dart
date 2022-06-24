import 'package:ecommercefood/src/modules/components/NavBar.dart';
import 'package:ecommercefood/src/modules/controller/state_controller.dart';
import 'package:ecommercefood/src/modules/models/Product.dart';
import 'package:ecommercefood/src/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  Product? product;
  ProductPage({this.product, Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  // ProductPage({ Key? key });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<StateController>(context);

    return Scaffold(
      appBar: const NavBar(),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(children: [
            Stack(
              children: [
                Container(
                  color: AppColors.foodBackground,
                  height: 300,
                ),
                widget.product != null
                    ? SafeArea(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: createColumn(size, context,
                              widget.product as Product, provider),
                        ),
                      )
                    : Container(),
              ],
            )
          ]),
        ),
      ),
    );
  }

  Widget createColumn(
      Size size, var context, Product product, StateController provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Container(
          width: size.width,
          height: 200,
          alignment: Alignment.center,
          // child: Image.network(
          //   product.imageUrl,
          //   fit: BoxFit.cover,
          // ),
          child: product.getImage(BoxFit.cover),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    product.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: product.isFavorite
                        ? AppColors.backgroundSplash
                        : Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      product.isFavorite = !product.isFavorite;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              product.getTotalFormat(),
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: AppColors.backgroundSplash,
              ),
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
                          if (product.quantity <= 0) return;
                          product.quantity = product.quantity - 1;
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
                          if (product.id == null) return;
                          provider.addProductShopping(product);
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
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            optional(textUp: 'Size', textDown: 'Médio'),
            const SizedBox(
              width: 20,
            ),
            optional(textUp: 'Energy', textDown: '554 KCal'),
            const SizedBox(
              width: 20,
            ),
            optional(textUp: 'Delivery', textDown: '45 min'),
          ],
        ),
        Column(
          children: [
            const SizedBox(height: 35),
            const Text("About"),
            Text(product.description),
            const SizedBox(height: 20),
            Container(
              width: size.width,
              // height: 50,
              decoration: BoxDecoration(
                color: product.quantity == 0
                    ? AppColors.backgroundSplash.withOpacity(0.8)
                    : AppColors.backgroundSplash,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                onPressed: () {
                  if (product.quantity == 0) {
                    snackBarMessageAddProduct(context);
                    return;
                  }
                  final provider =
                      Provider.of<StateController>(context, listen: false);
                  provider.addProductShopping(product);
                  Navigator.pop(context);
                },
                child: const Center(
                  child: Text(
                    'Adicionar ao carrinho',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  void snackBarMessageAddProduct(context) {
    final snackBar = SnackBar(
      content: const Text('Por favor, adicione uma quantidade ao produto!'),
      backgroundColor: Colors.red[400],
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Container optional({String textUp = '', String textDown = ''}) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.backgroundSplash,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              textUp,
              style: const TextStyle(
                color: AppColors.backgroundSplash,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 100,
            child: Text(
              textDown,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
