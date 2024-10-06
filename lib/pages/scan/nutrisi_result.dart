import 'package:flutter/material.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';

class NutrisiResult extends StatelessWidget {
  final List<Nutrisi> nutrisiList = [
    Nutrisi(label: 'Karbo', value: '45', satuan: 'g', color: Colors.red),
    Nutrisi(label: 'Protein', value: '20', satuan: 'g', color: Colors.green),
    Nutrisi(
        label: 'Kalori', value: '250', satuan: 'kcal', color: Colors.orange),
    Nutrisi(label: 'Sodium', value: '600', satuan: 'mg', color: Colors.blue),
    Nutrisi(label: 'Gula', value: '10', satuan: 'g', color: Colors.purple),
    Nutrisi(label: 'Fat', value: '15', satuan: 'g', color: Colors.brown),
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
  final Color color;

  Nutrisi(
      {required this.label,
      required this.value,
      required this.satuan,
      required this.color});
}

class NutrisiBox extends StatelessWidget {
  final Nutrisi nutrisi;

  const NutrisiBox({super.key, required this.nutrisi});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
        ),
        // Colored Circle
        Positioned(
          top: 0, // Adjust this value to position the circle
          left: 0, // Adjust this value to position the circle
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: nutrisi.color,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}
