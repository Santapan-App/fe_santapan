import 'package:flutter/material.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/pages/navbar.dart';
import 'package:santapan_fe/pages/scan/nutrisi_result.dart';
import 'package:santapan_fe/widget/button_custom.dart';

class ScanResultPage extends StatefulWidget {
  const ScanResultPage({super.key});

  @override
  State<ScanResultPage> createState() => _ScanResultPageState();
}

class _ScanResultPageState extends State<ScanResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppAssets.leftRoundedIcon,
                        width: 32,
                        height: 32,
                      ),
                      const SizedBox(width: 65),
                      Center(
                        child: Text(
                          "Hasil Rekomendasi",
                          style:
                              TypographyStyles.semiBold(20, ColorStyles.black),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          "https://picsum.photos/200/300",
                          width: 220,
                          height: 220,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        // Tambahkan Expanded di sini
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nama Makanan 12334i4884848",
                              style:
                                  TypographyStyles.semiBold(16, Colors.black),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "54 kalori/saji",
                              style: TypographyStyles.regular(14, Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  NutrisiResult(),
                  const SizedBox(height: 8),
                  Text("Rekomendasi Hidangan",
                      style: TypographyStyles.semiBold(16, Colors.black)),
                  const SizedBox(height: 4),
                  Text("Hidangan berikut cocok dengan makanan yang kamu scan!",
                      style: TypographyStyles.regular(14, ColorStyles.grey)),
                  const SizedBox(height: 10),
                  itemMenuMakan(),
                  const SizedBox(height: 32),
                  ButtonCustom(
                    label: "Kembali ke Beranda",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Navbar()));
                    },
                    isExpand: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container itemMenuMakan() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              "https://picsum.photos/200/300",
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nama Makanan",
                  style: TypographyStyles.semiBold(16, Colors.black),
                ),
                const SizedBox(height: 4),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                  style: TypographyStyles.regular(14, Colors.grey),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      "Rp40.000",
                      style: TypographyStyles.semiBold(16, ColorStyles.black),
                    ),
                    const SizedBox(width: 16),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "1.0",
                          style: TypographyStyles.regular(14, Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
