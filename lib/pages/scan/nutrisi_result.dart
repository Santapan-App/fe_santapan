import 'package:flutter/material.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';

class NutrisiResult extends StatelessWidget {
  final List<Nutrisi> nutrisiList = [
    Nutrisi(label: 'Karbo', value: '45', satuan: 'g'),
    Nutrisi(label: 'Protein', value: '20', satuan: 'g'),
    Nutrisi(label: 'Kalori', value: '250', satuan: 'kcal'),
    Nutrisi(label: 'Sodium', value: '600', satuan: 'mg'),
    Nutrisi(label: 'Gula', value: '10', satuan: 'g'),
    Nutrisi(label: 'Fat', value: '15', satuan: 'g'),
  ];

  NutrisiResult({super.key});

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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  NutrisiBox(nutrisi: nutrisiList[index]),
                  const SizedBox(height: 4),
                  Text(
                    nutrisiList[index].label,
                    style: TypographyStyles.regular(12, ColorStyles.black),
                    textAlign: TextAlign.center,
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

  Nutrisi({required this.label, required this.value, required this.satuan});
}

class NutrisiBox extends StatelessWidget {
  final Nutrisi nutrisi;

  const NutrisiBox({super.key, required this.nutrisi});

  @override
  Widget build(BuildContext context) {
    return
        // Nutrisi Box
        Container(
      width: 75,
      height: 53,
      margin: const EdgeInsets.only(right: 16),
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
            const SizedBox(width: 4), // Space between value and unit
            Text(
              nutrisi.satuan,
              style: TypographyStyles.regular(12, ColorStyles.black),
            ),
          ],
        ),
      ),

      // Colored Circle
    );
  }
}
