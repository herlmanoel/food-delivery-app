import 'package:ecommercefood/data/database.dart';
import 'package:ecommercefood/modules/models/Product.dart';
import 'package:flutter/cupertino.dart';

class ShoppingCart extends ChangeNotifier {
  static List<int> listIdsProducts = [];

   void addItem(int id) {
    listIdsProducts.add(id);
    notifyListeners();
  }

  void removeItem(int id) {
    listIdsProducts.remove(id);
    notifyListeners();
  }

    int get totalItens {
    return listIdsProducts.length;
  }

  static List<Product> getProducts() {
    return DatabaseProducts.listProductsData
        .where(
          (product) => listIdsProducts.contains(product.id),
        )
        .toList();
  }

  // double get total {
  //   double total = 0;
  //   for (int id in listIdsProducts) {
  //     total += ProductList().items.firstWhere((p) => p.id == id).price;
  //   }
  //   return total;
  // }
}
