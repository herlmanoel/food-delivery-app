import 'package:ecommercefood/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Column(
        children: [
          Stack(
            children: [
                Container(
                color: AppColors.backgroundSplash,
                height: 200,
              ),
            ],
          )
        ],
      ),
    );
  }
}