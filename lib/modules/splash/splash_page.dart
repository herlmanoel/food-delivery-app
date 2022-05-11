import 'package:ecommercefood/modules/splash/gradient.dart';
import 'package:flutter/material.dart';

import 'package:ecommercefood/modules/splash/button.dart';
import 'package:ecommercefood/shared/themes/app_colors.dart';
import 'package:ecommercefood/shared/themes/app_image.dart';
import 'package:ecommercefood/shared/themes/app_text_style.dart';

class SplashPage extends StatelessWidget {
  // const SplashPage({Key? key}) : super(key: key);
  toLogin(context) {
    Navigator.pushReplacementNamed(context, '/login');   
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        width:  size.width,
        height: size.height,
        color: AppColors.backgroundSplash,
        child: Stack(
           children: [
            Container(
              width: size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(AppImages.introFood),
                ),
              ),
              ),
              const GradientSplash(),
              Positioned(
                top: size.width * 0.8,
                child: Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Find and Get \nYour Best Food',
                           textAlign: TextAlign.left, 
                            style: AppTextStyles.titleHome,
                          ), 
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(
                                'Find the most delicious food \nwith the best quality and free \ndelivery here',
                                style: AppTextStyles.titleRegular,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: SizedBox(
                              width: size.width - 80,
                              child: Center(
                                child: ButtonSplash(
                                  onTap: () {
                                    toLogin(context);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ),
                ),
              ),
           ]
        )
      )
    );
  }
}