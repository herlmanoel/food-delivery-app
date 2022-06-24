import 'package:flutter/material.dart';

class GradientSplash extends StatelessWidget {
  const GradientSplash({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            const Color(0xFFC4C4C4).withOpacity(0),
            const Color(0x00000000).withOpacity(0.7),
          ],
        )
      ),
    );
  }
}