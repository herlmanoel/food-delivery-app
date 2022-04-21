import 'package:flutter/cupertino.dart';

class Category {
  int id;
  String title;
  Image icon;
  bool selected;
  Category ({ required this.id, required this.title, required this.icon, this.selected = false});
}