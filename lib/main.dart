import 'package:flutter/material.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/pages/beranda/detail_menu_page.dart';
import 'package:santapan_fe/pages/berlangganan/langganan_bulanan_page.dart';
import 'package:santapan_fe/pages/berlangganan/langganan_mingguan_page.dart';
import 'package:santapan_fe/pages/navbar.dart';
import 'package:santapan_fe/pages/onboarding_page.dart';
import 'package:santapan_fe/pages/payment/method_payment_page.dart';
import 'package:santapan_fe/pages/payment/payment_page.dart';
import 'package:santapan_fe/pages/pesanan/detail_status_pesanan_page.dart';
import 'package:santapan_fe/pages/scan/scan_result_page.dart';
import 'package:santapan_fe/pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: ColorStyles.bgScreen,
      ),
      debugShowCheckedModeBanner: false,
      home: LanggananBulananPage(),
    );
  }
}
