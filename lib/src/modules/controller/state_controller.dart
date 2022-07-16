import 'dart:convert';
import 'dart:math';

import 'package:ecommercefood/src/data/database.dart';
import 'package:ecommercefood/src/modules/models/Category.dart';
import 'package:ecommercefood/src/modules/models/Person.dart';
import 'package:ecommercefood/src/modules/models/Product.dart';
import 'package:ecommercefood/src/modules/models/ShoppingCart.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class StateController extends ChangeNotifier {
  List<Product> listProducts = [];
  ShoppingCart shoppingCart = ShoppingCart();
  Person person = Person(id: "u1", name: "Herlmanoel Fernandes", email: "herl@gmail.com", avatarUrl: "https://avatars.githubusercontent.com/u/35230448?v=4");
  

  final _baseUrl =
      'https://ecommerce-mini-projeto-04-default-rtdb.firebaseio.com';

  void addItem(Product product) {
    listProducts.add(product);
    notifyListeners();
  }

  // remove product shopping cart
  void removeItemShoppingCart(Product product) {
    shoppingCart.removeItem(product.id as String);
    notifyListeners();
  }

  void removeItem(Product product) {
    listProducts.remove(product);
    notifyListeners();
  }

  int get totalItens {
    return listProducts.length;
  }

  double get totalPriceShoppingCart {
    double total = 0.0;
    if(getProductsShopping().isEmpty) {
      return total;
    }

    getProductsShopping().forEach((product) {
      total += product.price * product.quantity;
    });
    return total;
  }

  String get totalPriceShoppingCartFormat {
    return "R\$ ${totalPriceShoppingCart.toStringAsFixed(2).replaceAll('.', ',')}";
  }

  List<Product> getProducts() {
    if(listProducts.isEmpty) {
      return getProductsFirebase();
    }else {
      return listProducts;
    }
  }

  List<Product> getProductsFirebase() {
    http.get(Uri.parse(_baseUrl + '/products.json')).then((response) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<Product> loadedProducts = [];
      data.forEach((id, prod) {
        final String title = prod['title'];
        final String description = prod['description'];
        final double price = double.parse(prod['price'].toString());
        final String imageUrl = prod['imageUrl'];
        final int category = prod['category'];
        final bool isFavorite = prod['isFavorite'];

        loadedProducts.add(Product(
          id: id,
          name: title,
          description: description,
          price: price,
          imageUrl: imageUrl,
          isFavorite: isFavorite,          
          categoryId: category,
        ));        
      });
      listProducts.clear();
      listProducts.addAll(loadedProducts);
      print("Cerregou os produtos");
      notifyListeners();
    });
    return [...listProducts];
  }

  List<Product> getProductsShopping() {
    return listProducts
        .where(
          (product) => shoppingCart.listIdsProducts.contains(product.id),
        )
        .toList();
  }

  void addProductShopping(Product product) {
    print("add");
    shoppingCart.addItem(product.id as String);
    notifyListeners();
  }

  List<Product> getFavoriteProducts() {
    return getProducts().where((p) => p.isFavorite).toList();
  }

  toggleFavorite(Product product) {
    product.toggleFavorite();
    notifyListeners();
  }

  Future<void> addProduct(Product product) {
    return postFirebase(product).then((response) {
      final id = jsonDecode(response.body)['name'];
      product.id = id;
      listProducts.add(product);
      notifyListeners();
    }).catchError((error) {
      print(error);
    });
  }

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['title'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
      categoryId: int.parse(data['category'] as String),
    );

    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  Category getCategory(int index) {
    return DatabaseProducts.getListCategoriesOrderByTitle()[index];
  }

  void updateProductList(Product product) {
    final index = listProducts.indexWhere((prod) => prod.id == product.id);
    if (index >= 0) {
      listProducts[index] = product;
    }
    notifyListeners();
  }

  Future<void> updateProduct(Product product) {
    int index = listProducts.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      listProducts[index] = product;
      updateProductInFirebase(product).then((_) {
        notifyListeners();
      }).catchError((e) {
        print(e);
      });
    }
    return Future.value();
  }

  Future<void> updateProductInFirebase(Product product) {
    final url = '$_baseUrl/products/${product.id}.json';
    return http.patch(
      Uri.parse(url),
      body: jsonEncodeProduct(product),
    );
  }

  void removeProduct(Product product) {
    int index = listProducts.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      listProducts.removeWhere((p) => p.id == product.id);
      removeProductInFirebase(product).then((_) {
        notifyListeners();
      }).catchError((e) {
        print(e);
      });
    }
  }

  Future<void> removeProductInFirebase(Product product) {
    final url = '$_baseUrl/products/${product.id}.json';
    return http.delete(Uri.parse(url));
  }

  Future<http.Response> postFirebase(Product product) {
    print(jsonEncodeProduct(product));
    return http.post(
      Uri.parse('$_baseUrl/products.json'),
      body: jsonEncodeProduct(product),
    );
  }

  String jsonEncodeProduct(Product product) {
    return jsonEncode({
        "title": product.name,
        "description": product.description,
        "price": product.price,
        "imageUrl": product.imageUrl,
        "isFavorite": product.isFavorite,
        "category": product.categoryId,
      });
  }
}
