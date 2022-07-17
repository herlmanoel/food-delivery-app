import 'dart:convert';
import 'dart:math';

import 'package:ecommercefood/src/data/database.dart';
import 'package:ecommercefood/src/modules/models/Category.dart';
import 'package:ecommercefood/src/modules/models/Person.dart';
import 'package:ecommercefood/src/modules/models/Product.dart';
import 'package:ecommercefood/src/modules/models/ShoppingCart.dart';
import 'package:ecommercefood/src/shared/geolocator/app_geolocator.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class StateController extends ChangeNotifier {
  List<Product> listProducts = [];
  ShoppingCart shoppingCart = ShoppingCart();
  Person person = Person(
      id: "u1",
      name: "Herlmanoel Fernandes",
      email: "herl@gmail.com",
      avatarUrl: "https://avatars.githubusercontent.com/u/35230448?v=4");

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
    if (getProductsShopping().isEmpty) {
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
    if (listProducts.isEmpty) {
      return getProductsFirebase();
    } else {
      return listProducts;
    }
  }

  List<Product> getProductsFirebase() {
    http.get(Uri.parse(_baseUrl + '/products.json')).then((response) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<Product> loadedProducts = [];
      data.forEach((id, prod) {
        try {
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
        } catch (e) {
          print('Erro! id: ($id prod: $prod) $e');
        }
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

  Future<void> saveLocationInFirebase() async {
    // get location
    Position position = await AppGeolocator.determinePosition();
    final url = '$_baseUrl/LoginLocation.json';
    http.post(
      Uri.parse(url),
      body: jsonEncode(positionToJson(position)),
    );
  }

  Map<String, dynamic> positionToJson(Position position) {
    return {
      "latitude": position.latitude,
      "longitude": position.longitude,
      "data_criacao": DateTime.now().toString(),
    };
  }

  createProductsInFirebase() async {}

  List<String> listImagesSandwitch = [
    'https://purepng.com/public/uploads/large/purepng.com-sandwichfood-slice-salad-tasty-bread-vegetable-health-delicious-breakfast-sandwich-9415246186167yco8.png',
    'https://purepng.com/public/uploads/large/purepng.com-sandwichfood-slice-salad-tasty-bread-vegetable-health-delicious-breakfast-sandwich-941524618174fdhlh.png',
    'https://www.pngplay.com/wp-content/uploads/2/Sandwich-PNG-HD-Quality.png',
    'https://www.pngplay.com/wp-content/uploads/2/Sandwich-PNG-HD-Quality.png',
    'https://www.pngmart.com/files/16/Cheese-Sandwich-PNG-Photos.png',
    'https://www.pngplay.com/wp-content/uploads/1/Subway-Sandwich-PNG-HD-Quality.png',
  ];

  List<String> listImagesPizza = [
    'https://i0.wp.com/multarte.com.br/wp-content/uploads/2019/03/pizzas-png-transparente.png?fit=950%2C768&ssl=1',
    'https://pizzariadahora.com.br/wp-content/uploads/2022/04/pizza.png',
    'https://imagensemoldes.com.br/wp-content/uploads/2020/04/Peda%C3%A7o-de-Pizza-PNG-1024x563.png',
    'https://www.imagensempng.com.br/wp-content/uploads/2021/02/20-2.png',
    'http://pngimg.com/uploads/pizza/pizza_PNG44084.png',
    'https://www.seekpng.com/png/full/7-70471_fatia-pizza-png-pizza-massa-fina-png.png',
    'https://static.wixstatic.com/media/c12ed4_de2ff20eb8af42208da7a8d3a4304319~mv2.png/v1/fill/w_560,h_348,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/IMAGEM%20PIZZA.png',
  ];

  List<String> listImagesBurger = [
    'https://i.pinimg.com/originals/6c/ee/58/6cee589c2f553320ee93e5afced09766.png',
    'https://www.pngmart.com/files/5/Hamburger-PNG-HD.png',
    'https://uploaddeimagens.com.br/images/003/242/810/original/burger-png-hd-burger-sriracha-burger-png-1119.png?1621010222',
    'https://upload.wikimedia.org/wikipedia/commons/1/11/Cheeseburger.png',
    'https://www.freeiconspng.com/uploads/hamburger-burger-png-image-12.png',
    'https://pngimg.com/uploads/burger_sandwich/burger_sandwich_PNG4132.png',
  ];

  List<Product> cargaProductsFirebase() {
    List<Product> listProductsIn = [];
    int index = 1;
    for (var element in listImagesSandwitch) {
      index++;
      listProductsIn.add(Product(
        id: 'p$index',
        name: 'Sandwich',
        description: 'Sandwich $index',
        price: double.parse((index * 10).toString()),
        imageUrl: element,
        isFavorite: false,
        categoryId: 1,
      ));
    }

    for (var element in listImagesPizza) {
      index++;
      listProductsIn.add(Product(
        id: 'p$index',
        name: 'Pizza',
        description: 'Pizza $index',
        price: double.parse((index * 10).toString()),
        imageUrl: element,
        isFavorite: false,
        categoryId: 2,
      ));
    }

    for (var element in listImagesBurger) {
      index++;
      listProductsIn.add(Product(
        id: 'p$index',
        name: 'Burger',
        description: 'Burger $index',
        price: double.parse((index * 10).toString()),
        imageUrl: element,
        isFavorite: false,
        categoryId: 3,
      ));
    }

    return listProductsIn;
  }

  cargaProductsInFirebase() async {
    List<Product> listProductsIn = cargaProductsFirebase();
    for (var element in listProductsIn) {
      postFirebase(element).then((response) {
        print(response.body);
      });
    }
  }
}
