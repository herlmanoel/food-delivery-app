import 'dart:ffi';

import 'package:flutter/material.dart';

class Product {
  int id;
  double starts;
  String name;
  String description;
  Image image;
  double price;
  Product({
    required this.id,
    this.starts = 0.0,
    required this.name,
    this.description = '',
    required this.image,
    required this.price,
  });
}