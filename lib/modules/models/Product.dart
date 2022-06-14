import 'package:ecommercefood/modules/models/Category.dart';
import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  String? id;
  String name;
  String description;
  double price;
  bool isFavorite;
  Category? category;
  int categoryId;
  int quantity = 0;
  String imageUrl = '';

  Product({
    this.id,
    required this.name,
    this.description = '',
    required this.price,
    this.isFavorite = false,
    this.imageUrl = '',
    required this.categoryId,
  });

  String getTotalFormat() {
    if (quantity <= 0) {
      return 'R\$ ${price.toStringAsFixed(2)}';
    }
    return 'R\$ ${(price * quantity).toStringAsFixed(2)}';
  }

  String getPriceFormat() {
    if (quantity <= 0) {
      return 'R\$ ${price.toStringAsFixed(2)}';
    }
    return 'R\$ ${price.toStringAsFixed(2)}';
  }

  double getTotal() {
    if (quantity <= 0) {
      return price;
    }
    return price * quantity;
  }

  int get getQuantity {
    return quantity;
  }

  incrementQuantity() {
    quantity++;
    notifyListeners();
  }

  decrementQuantity() {
    if (quantity <= 0) return;
    quantity--;
    notifyListeners();
  }

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, description: $description, price: $price, isFavorite: $isFavorite, categoryId: $categoryId, quantity: $quantity, imageUrl: $imageUrl}';
  }
}
