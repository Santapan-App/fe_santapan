import 'package:flutter/material.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/pages/navbar.dart';
import 'package:santapan_fe/pages/scan/nutrisi_result.dart';
import 'package:santapan_fe/widget/alert_danger_scan.dart';
import 'package:santapan_fe/widget/alert_success_scan.dart';
import 'package:santapan_fe/widget/alert_warning_scan.dart';
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
                    overflow: TextOverflow.clip,
                  ),
                  const SizedBox(height: 24),
                  // Alert Widget
                  AlertDangerScan(),
                  AlertSuccessScan(),
                  AlertWarningScan(),
                  const SizedBox(height: 16),
                  NutrisiResult(),
                  const SizedBox(
                    height: 42,
                  ),
                  ButtonCustom(
                    label: "Kembali ke Beranda",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Navbar()));
                    },
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
