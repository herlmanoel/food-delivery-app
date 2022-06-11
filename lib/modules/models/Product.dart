import 'package:ecommercefood/modules/models/Category.dart';
import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  String? id;
  double starts;
  String name;
  String description;
  double price;
  int amountReviews;
  bool isFavorite;
  Category category;
  int quantity = 0;
  String imageUrl = '';

  Product({
    this.id,
    this.starts = 0.0,
    required this.name,
    this.description = '',
    required this.price,
    this.amountReviews = 0,
    this.isFavorite = false,
    required this.category,
    this.imageUrl = '',
  });

  String getPriceFormat() {
    if(quantity <= 0) {
      return 'R\$ ${price.toStringAsFixed(2)}';
    } 
    return 'R\$ ${(price * quantity).toStringAsFixed(2)}'; 
  }

  double getPrice() {
    if(quantity <= 0) {
      return price;
    } 
    return price * quantity; 
  }


  String getAmountReviewsFormat() {
    return '($amountReviews ${amountReviews == 1 ? 'review' : 'reviews'})';
  }

  incrementQuantity() {
    quantity++;
    notifyListeners();
  }

  decrementQuantity() {
    if(quantity <= 0) return;
    quantity--;
    notifyListeners();
  }

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}