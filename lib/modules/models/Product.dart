import 'package:ecommercefood/modules/models/Category.dart';
import 'package:flutter/material.dart';

class Product {
  int id;
  double starts;
  String name;
  String description;
  Image image;
  double price;
  int amountReviews;
  bool isFavorite;
  Category category;
  int quantity = 0;
  Product({
    required this.id,
    this.starts = 0.0,
    required this.name,
    this.description = '',
    required this.image,
    required this.price,
    this.amountReviews = 0,
    this.isFavorite = false,
    required this.category,
  });

  String getPriceFormat() {
    if(quantity <= 0) {
      return 'R\$ ${price.toStringAsFixed(2)}';
    } 
    return 'R\$ ${(price * quantity).toStringAsFixed(2)}';
    
  }

  String getAmountReviewsFormat() {
    return '($amountReviews ${amountReviews == 1 ? 'review' : 'reviews'})';
  }

  incrementQuantity() {
    quantity = quantity++;
  }

  decrementQuantity() {
    if(quantity <= 0) return;
    quantity = quantity++;
  }
}