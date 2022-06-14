import 'package:ecommercefood/modules/components/cart/ModalCart.dart';
import 'package:ecommercefood/modules/pages/SettingsPage.dart';
import 'package:flutter/material.dart';

class MenuBar extends StatefulWidget {
  const MenuBar({Key? key}) : super(key: key);

  @override
  State<MenuBar> createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFFFFFFF).withOpacity(0),
            const Color(0xFFFFFFFF).withOpacity(0.8),
            const Color(0xFFFFFFFF).withOpacity(1),
          ],
        ),
      ),
      height: 56,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              currentPage = 0;
              // Navigator.pushNamed(context, '/');
              setState(() {});
            },
            icon: Icon(
              Icons.home,
              color: currentPage == 0
                  ? const Color(0xFFFF941A)
                  : const Color(0xFF706E7A),
            ),
          ),
          IconButton(
            onPressed: () {
              currentPage = 1;
              // Navigator.pushNamed(context, '/favorites');
              setState(() {});
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
            },
            icon: Icon(
              Icons.settings,
              color: currentPage == 1
                  ? const Color(0xFFFF941A)
                  : const Color(0xFF706E7A),
            ),
          ),
        ],
      ),
    );
  }

  void exibeModal() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return const ModalCart();
        });
  }
}
