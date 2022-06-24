import 'package:ecommercefood/src/modules/models/Category.dart';
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
    this.quantity = 0,
  });

  String getTotalFormat() {
    if (quantity <= 0) {
      return 'R\$ ${price.toStringAsFixed(2).replaceAll('.', ',')}';
    }
    return 'R\$ ${(price * quantity).toStringAsFixed(2).replaceAll('.', ',')}';
  }

  String getPriceFormat() {
    if (quantity <= 0) {
      return 'R\$ ${price.toStringAsFixed(2).replaceAll('.', ',')}';
    }
    return 'R\$ ${price.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  double getTotal() {
    if (quantity <= 0) {
      return price;
    }
    return price * quantity;
  }

  int getQuantity() {
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

  String getDescriptionResume() {
    int numChars = 10;
    if (description.length > numChars) {
      return description.substring(0, numChars) + '...';
    }
    return description;
  }

  String getNameResume() {
    int numChars = 15;
    if (name.length > numChars) {
      return name.substring(0, numChars) + '...';
    }
    return name;
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, description: $description, price: $price, isFavorite: $isFavorite, categoryId: $categoryId, quantity: $quantity, imageUrl: $imageUrl}';
  }
}
