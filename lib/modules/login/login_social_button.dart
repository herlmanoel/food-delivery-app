import 'package:flutter/material.dart';

import '../../shared/themes/app_colors.dart';
import '../../shared/themes/app_image.dart';
import '../../shared/themes/app_text_style.dart';

class SocialLoginButton extends StatelessWidget  {
  final VoidCallback onTap;
  const SocialLoginButton({Key? key, required this.onTap}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    // tamanho da tela
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56,
        width: size.width * 0.8,
        decoration:  BoxDecoration(
          color: AppColors.shape,
          borderRadius: BorderRadius.circular(5),
          border: const Border.fromBorderSide(BorderSide(color: AppColors.stroke))
        ),
        child: Row(children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Image.asset(AppImages.google),
                ),
                Container(height: 56, width: 1, color: AppColors.stroke)
              ],
            )
          ),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Entrar com o Google', style: AppTextStyles.buttonGrey,),
              ],
            )),
            Expanded(child: Container(),)
        ],
        
        ),
      ),
    );
  }

}
