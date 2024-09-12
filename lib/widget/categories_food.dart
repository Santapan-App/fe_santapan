import 'package:flutter/material.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';

class CategoriesFood extends StatelessWidget {
  const CategoriesFood({
    super.key,
    required this.image,
    required this.text,
  });
  final String image;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          image,
          height: 60,
        ),
        const SizedBox(
          height: 6,
        ),
        Text(text, style: TypographyStyles.semiBold(10, ColorStyles.black))
      ],
    );
  }
}
