
import 'package:ecommercefood/modules/home/CardProduct.dart';
import 'package:ecommercefood/modules/models/Category.dart';
import 'package:ecommercefood/modules/models/Product.dart';
import 'package:ecommercefood/shared/themes/app_colors.dart';
import 'package:ecommercefood/shared/themes/app_image.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {


  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

    var listCategories = [
      Category(id: 1, title: 'Sandwich', icon: Image.asset(AppImages.hotDogIcon), selected: true),
      Category(id: 2, title: 'Pizza', icon: Image.asset(AppImages.pizzaIcon)),
      Category(id: 3, title: 'Burguer', icon: Image.asset(AppImages.burguerIcon)),
    ];

    var listProducts = [
      Product(id: 1, name: 'Chicken burger', description: "200 gr chicken + cheese  Lettuce + tomato", image: Image.asset(AppImages.burguerProduct), price: 20),
      Product(id: 2, name: 'Chicken burger', description: "200 gr chicken + cheese  Lettuce + tomato", image: Image.asset(AppImages.burguerProduct), price: 30),
      Product(id: 3, name: 'Chicken burger', description: "200 gr chicken + cheese  Lettuce + tomato", image: Image.asset(AppImages.burguerProduct), price: 40),
      Product(id: 4, name: 'Chicken burger', description: "200 gr chicken + cheese  Lettuce + tomato", image: Image.asset(AppImages.burguerProduct), price: 50),
      Product(id: 5, name: 'Chicken burger', description: "200 gr chicken + cheese  Lettuce + tomato", image: Image.asset(AppImages.burguerProduct), price: 60),
      Product(id: 6, name: 'Chicken burger', description: "200 gr chicken + cheese  Lettuce + tomato", image: Image.asset(AppImages.burguerProduct), price: 70),
      Product(id: 7, name: 'Chicken burger', description: "200 gr chicken + cheese  Lettuce + tomato", image: Image.asset(AppImages.burguerProduct), price: 80),
    ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const paddingSafeArea = 20.0;
    final widthSafeArea = size.width - (paddingSafeArea * 2);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: paddingSafeArea),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  const Text('Order Your Food\nFast and Free',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                    ),
                  ),
                  Image.asset(AppImages.delivery),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: size.width * 0.72,
                    height: 61,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Search',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    // padding: const EdgeInsets.all(1.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.backgroundSplash),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    // width: size.width * 0.2,
                    height: 61,
                    child: Image.asset(AppImages.filterIcon),
                  )
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: widthSafeArea,
                child: const Text("Categories",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 18),

              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listCategories.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    Category category = listCategories[index];
                    return buttonCategory(category);
                  },
                ),
              ),
              const SizedBox(height: 20),
              Expanded(child: 
                
                GridView.builder(
                  padding: const EdgeInsets.symmetric(vertical: paddingSafeArea),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 0.68,
                  ),
                  itemBuilder: (context, i) =>  
                  CardProduct(widthFather: widthSafeArea, product: listProducts[i]),
                  itemCount: listProducts.length,
                ),
              )
            ]
          ),
        ),
      ),
    );
  }

  Container buttonCategory(Category category) {
    var icon = category.icon;
    var title = category.title;
    var selected = category.selected;
    var id = category.id;
    return
      Container(
        margin: const EdgeInsets.only(right: 10),
        
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: selected ? AppColors.backgroundSplash : Colors.transparent,
          border: Border.all(color: AppColors.backgroundSplash),
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextButton.icon(
          onPressed: () {
            setState(() {
              var elementCurrent = listCategories.firstWhere((element) => element.id == id);
              var elementSelected = listCategories.firstWhere((element) => element.selected == true);
              elementCurrent.selected = true;
              elementSelected.selected = false;
              listCategories.sort((a, b) => a.selected ? -1 : 1);
            });
          },  
          icon: icon,
          label: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: selected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      );
  }
}