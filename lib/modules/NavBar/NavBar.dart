import 'package:ecommercefood/modules/Modal/ModalCart.dart';
import 'package:ecommercefood/modules/favorites/FavoritePage.dart';
import 'package:flutter/material.dart';
import '../../shared/themes/app_colors.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  const NavBar({Key? key}) : super(key: key);
  toFavorites(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FavoritesPage()),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.backgroundSplash,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.favorite),
          tooltip: 'Show Snackbar',
          onPressed: () {
            toFavorites(context);
          },
        ),
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          tooltip: 'Go to the next page',
          onPressed: () {
            showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return const ModalCart();
                });
          },
        ),
      ],
    );
  }
}
