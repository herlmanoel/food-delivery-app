import 'package:ecommercefood/modules/models/Category.dart';
import 'package:ecommercefood/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

class CategoriesMenu extends StatelessWidget {
  Category category;
  final Function(Function()) setState;
  List<Category> listCategories;
  final Function(int id) setIdSelectCategory;

  CategoriesMenu({
    required this.category, 
    required this.setState,
    required this.setIdSelectCategory,
    required this.listCategories,
     Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var icon = category.icon;
    var title = category.title;
    var selected = category.selected;
    var id = category.id;
    
    return Transform.scale(
      scale: 0.9,
      child: Container(
        margin: const EdgeInsets.only(right: 2),
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: selected ? AppColors.backgroundSplash : Colors.transparent,
          border: Border.all(color: AppColors.backgroundSplash),
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextButton.icon(
          onPressed: () {
            setState(() {
              updateCategorySelected(id);
              setIdSelectCategory(id);
            });
          },
          icon: icon,
          label: Text(
            title,
            style: TextStyle(
                fontSize: 18,
                color: selected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  sortListCategory() {
    listCategories.sort((a, b) => a.selected ? -1 : 1);
  }

  updateCategorySelected(int id) {
    Category elementCurrent =
        listCategories.firstWhere((element) => element.id == id);
    Category elementSelected =
        listCategories.firstWhere((element) => element.selected == true);
    elementCurrent.selected = true;
    elementSelected.selected = false;
    sortListCategory();
  }
}
