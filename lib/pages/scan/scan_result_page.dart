import 'package:flutter/material.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/pages/beranda/nutrisi_info.dart';
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
            imageScan(context),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hasil Scan Nama Makanan",
                    style: TypographyStyles.semiBold(20, ColorStyles.black),
                  ),
                  const SizedBox(height: 12),
                  // Alert Widget
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(0xFFF5A324),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.warning,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              "Kamu boleh kok makan ini asal jangan terlalu banyak ya ..🙂",
                              style:
                                  TypographyStyles.semiBold(14, Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  NutrisiInfo(),
                  const SizedBox(
                    height: 32,
                  ),
                  ButtonCustom(
                    label: "Kembali ke Beranda",
                    onTap: () {},
                    isExpand: true,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Stack imageScan(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 330,
          child: Image.network(
            "https://picsum.photos/200/300",
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 50,
          left: 16,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              AppAssets.leftRoundedIcon,
              width: 40,
              height: 40,
            ),
          ),
        ),
      ],
    );
  }
}
