
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
    return 'R\$${price.toStringAsFixed(2)}';
  }

  String getAmountReviewsFormat() {
    return '($amountReviews ${amountReviews == 1 ? 'review' : 'reviews'})';
  }
}