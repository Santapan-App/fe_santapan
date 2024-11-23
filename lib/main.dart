import 'package:flutter/material.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/pages/akun/bantuan_page.dart';
import 'package:santapan_fe/pages/akun/edit_profile_page.dart';
import 'package:santapan_fe/pages/akun/ubah_password_page.dart';
import 'package:santapan_fe/pages/auth/verification_page.dart';
import 'package:santapan_fe/pages/auth/verification_success_page.dart';
import 'package:santapan_fe/pages/beranda/detail_menu_page.dart';
import 'package:santapan_fe/pages/navbar.dart';
import 'package:santapan_fe/pages/payment/payment_page.dart';
import 'package:santapan_fe/pages/personalisasi/personalisasi_page.dart';
import 'package:santapan_fe/pages/scan/scan_result_page.dart';
import 'package:santapan_fe/pages/splash_page.dart';

void main() {
  runApp(const Santapan());
}

class Santapan extends StatelessWidget {
  const Santapan({super.key});
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    navigatorKey = Santapan.navigatorKey;
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: ColorStyles.bgScreen,
      ),
      debugShowCheckedModeBanner: false,
      home: Navbar(),
    );
  }
}
