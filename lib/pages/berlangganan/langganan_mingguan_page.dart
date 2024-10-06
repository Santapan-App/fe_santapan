import 'package:flutter/material.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/widget/button_custom.dart';

class LanggananMingguanPage extends StatefulWidget {
  const LanggananMingguanPage({super.key});

  @override
  State<LanggananMingguanPage> createState() => _LanggananMingguanPageState();
}

class _LanggananMingguanPageState extends State<LanggananMingguanPage> {
  int quantity = 1;
  final double pricePerItem = 50000;
  double get totalPrice => pricePerItem * quantity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                imageTop(context),
                const SizedBox(height: 16),
                ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: 7,
                  shrinkWrap: true, // Allow the ListView to take its height
                  physics:
                      const NeverScrollableScrollPhysics(), // Disable scrolling
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        foodCard(context, index + 1),
                        const SizedBox(height: 6),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          bottomButton()
        ],
      ),
    );
  }

  Positioned bottomButton() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: ColorStyles.grey.withOpacity(0.1),
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Total Harga",
                style: TypographyStyles.semiBold(14, ColorStyles.grey),
              ),
              const SizedBox(height: 4),
              Text(
                "Rp ${totalPrice.toString()}",
                style: TypographyStyles.bold(16, ColorStyles.black),
              ),
              const SizedBox(height: 14),
              ButtonCustom(
                label: "Langganan sekarang",
                onTap: () {
                  // Handle add to cart logic
                },
                isExpand: true,
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }

  Stack imageTop(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 244,
          child: Image.asset(
            AppAssets.bannerMingguan,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 65,
          left: 16,
          right: 0,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  AppAssets.leftRoundedIcon,
                  width: 40,
                  height: 40,
                ),
              ),
              const SizedBox(width: 100),
              Text(
                "Mingguan",
                style: TypographyStyles.bold(20, Colors.black),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Card foodCard(BuildContext context, int day) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hari $day',
              style: TypographyStyles.bold(20, Colors.black),
            ),
            const SizedBox(height: 4),
            menuSection("Lunch", day),
            const SizedBox(height: 4),
            menuSection("Dinner", day),
          ],
        ),
      ),
    );
  }

  // Widget untuk menu lunch dan dinner
  Widget menuSection(String mealType, int day) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              width: 60,
              height: 60,
              child: Image.network(
                "https://picsum.photos/id/237/200/300",
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$mealType - Nama Menu Makan',
                  style: TypographyStyles.bold(16, Colors.black),
                ),
                const SizedBox(height: 4),
                Text(
                  'Deskripsi singkat untuk $mealType pada hari $day.',
                  style: TypographyStyles.regular(14, Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
