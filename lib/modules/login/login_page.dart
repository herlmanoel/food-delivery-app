import 'package:ecommercefood/modules/login/login_controller.dart';
import 'package:ecommercefood/modules/login/login_social_button.dart';
import 'package:ecommercefood/shared/themes/app_colors.dart';
import 'package:ecommercefood/shared/themes/app_image.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginController = LoginController();
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.background,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    color: AppColors.backgroundSplash,
                    height: height * 0.4,
                  ),
                  SafeArea(
                    child: Center(
                      child: Image.asset(AppImages.entregador)
                    ),
                  ),
                  const GradientLoginImage(),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "All your\nfavorites foods",
                textAlign: TextAlign.center,
                style: TextStyle(
                  
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "from your favorite\nrestaurants",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  // fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.1,),
              SocialLoginButton(onTap: () => loginController.googlesignin(context)),
            ],
          ),
        ),
      ),
    );
  }
}


class GradientLoginImage extends StatelessWidget {
  const GradientLoginImage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.4,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.13,
        width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFFFFFFF).withOpacity(0),
              const Color(0xFFFFFFFF).withOpacity(0.8),
              const Color(0xFFFFFFFF).withOpacity(1),
            ],
          )
        ),
      ),
    );
  }
}