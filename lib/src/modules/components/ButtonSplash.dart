import 'package:ecommercefood/src/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

class ButtonSplash extends StatelessWidget  {
  final VoidCallback onTap;
  const ButtonSplash({Key? key, required this.onTap}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    // tamanho da tela
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 65,
        width: 65,
        
        decoration:  BoxDecoration(
          color: AppColors.backgroundSplash,
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Center(
          child: Icon(
            Icons.arrow_forward_ios_rounded, 
            color: Colors.white,
          )
        )
      ),
    );
  }

}
