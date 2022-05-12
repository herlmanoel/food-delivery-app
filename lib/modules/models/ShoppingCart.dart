import 'package:ecommercefood/data/database.dart';
import 'package:ecommercefood/modules/models/Product.dart';

class ShoppingCart {
  static List<int> listIdsProducts = [];

  static List<Product> getProducts() {
    return DatabaseProducts.listProductsData
        .where(
          (product) => listIdsProducts.contains(product.id),
        )
        .toList();
  }
}
