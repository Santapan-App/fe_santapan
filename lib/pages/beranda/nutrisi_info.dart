import 'package:flutter/material.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/data/models/menu_detail_model.dart';

class NutrisiInfo extends StatelessWidget {
  final Nutrition nutrition;

  late final List<Nutrisi> nutrisiList;

  // Fix: Correctly passing nutrition in the constructor
  NutrisiInfo({super.key, required this.nutrition}) {
    nutrisiList = [
      Nutrisi(label: 'Protein', value: nutrition.protein?.toString() ?? '0', satuan: 'g'),
      Nutrisi(label: 'Kalori', value: nutrition.calories?.toString() ?? '0', satuan: 'kcal'),
      Nutrisi(label: 'Fat', value: nutrition.fat?.toString() ?? '0', satuan: 'g'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nutrisi',
          style: TypographyStyles.bold(16, ColorStyles.black),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: nutrisiList.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  NutrisiBox(nutrisi: nutrisiList[index]),
                  const SizedBox(height: 4),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      nutrisiList[index].label,
                      style: TypographyStyles.regular(12, ColorStyles.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class Nutrisi {
  final String label;
  final String value;
  final String satuan;

  Nutrisi({
    required this.label,
    required this.value,
    required this.satuan,
  });
}

class NutrisiBox extends StatelessWidget {
  final Nutrisi nutrisi;

  const NutrisiBox({super.key, required this.nutrisi});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      height: 53,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              nutrisi.value,
              style: TypographyStyles.bold(16, ColorStyles.black),
            ),
            const SizedBox(width: 4),
            Text(
              nutrisi.satuan,
              style: TypographyStyles.regular(12, ColorStyles.black),
            ),
          ],
        ),
      ),
    );
  }
}
