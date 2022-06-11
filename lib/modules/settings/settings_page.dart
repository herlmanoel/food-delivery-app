import 'package:ecommercefood/modules/controller/state_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed('/form-product');
            },
          ),
        ],
      ),
      body: Container(
        child: _buildProductList(context),
      ),
    );
  }

  Widget _buildProductList(BuildContext context) {
    final provider = Provider.of<StateController>(context);
    return ListView.builder(
      itemCount: provider.getProducts().length,
      itemBuilder: (_, index) {
        final product = provider.getProducts()[index];
        return ListTile(
          // leading: CircleAvatar(
          //   child: Padding(
          //     padding: const EdgeInsets.all(5),
          //     child: FadeInImage.assetNetwork(
          //       placeholder: 'assets/images/no-image.png',
          //       image: product.imageUrl,
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          title: Text(product.name),
          subtitle: Text('R\$ ${product.price.toStringAsFixed(2)}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    '/form-product',
                    arguments: product,
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  // provider.removeProduct(product);
                },
              ),
            ],
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              '/',
              arguments: product,
            );
          },
        );
      },
    );
  }
}
