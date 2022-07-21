import 'package:ecommercefood/src/modules/controller/state_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/themes/app_colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundSplash,
        title: const Text('Configurações'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed('/form-product');
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');  
          },
        ),
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
                  provider.removeProduct(product);
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
