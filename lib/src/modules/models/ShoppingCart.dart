import 'package:ecommercefood/src/data/database.dart';
import 'package:ecommercefood/src/modules/models/Product.dart';
import 'package:flutter/cupertino.dart';

class ShoppingCart extends ChangeNotifier {
  List<String> listIdsProducts = [];

   void addItem(String id) {
    listIdsProducts.add(id);
    notifyListeners();
  }

  void removeItem(String id) {
    listIdsProducts.remove(id);
    notifyListeners();
  }

    int get totalItens {
    return listIdsProducts.length;
  }

  List<Product> getProductsShopping() {
    return DatabaseProducts.listProductsData
        .where(
          (product) => listIdsProducts.contains(product.id),
        )
        .toList();
  }

  List<Product> getProducts() {
    return DatabaseProducts.listProductsData;
  }

  double get total {
    double total = 0;
    if(getProductsShopping().isEmpty){
      return total;
    }
    
    for (String id in listIdsProducts) {
      total += (getProductsShopping().firstWhere((p) => p.id == id).getTotal());
    }
    return total;
  }
}
