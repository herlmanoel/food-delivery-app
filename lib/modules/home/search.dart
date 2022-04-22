import 'package:flutter/material.dart';

import '../../shared/themes/app_colors.dart';
import '../../shared/themes/app_image.dart';

class Search extends StatelessWidget {
  const Search({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}