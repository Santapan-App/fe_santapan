import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/data/models/personalisasi_model.dart';
import 'package:santapan_fe/data/utils/auth_utils.dart';
import 'package:santapan_fe/pages/navbar.dart';
import 'package:santapan_fe/pages/onboarding_page.dart';
import 'package:santapan_fe/pages/personalisasi/personalisasi_page.dart';
import 'package:santapan_fe/pages/personalisasi/riwayat_penyakit_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    _startNavigation();
  }

  void _startNavigation() {
    Future.delayed(const Duration(seconds: 2), () async {
      await AuthUtility.getAccessToken();
      await AuthUtility.getUserPreferences();
      await _navigateBasedOnAuthStatus();
    });
  }

  Future<void> _navigateBasedOnAuthStatus() async {
    final userToken = AuthUtility.accessToken;
    if (userToken != null) {
      var preferences = AuthUtility.userPreferences;
      if (preferences != null) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const Navbar(),
          ),
          (route) => false,
        );
      } else {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const RiwayatPenyakitPage(),
          ),
          (route) => false,
        );
      }
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const OnboardingPage(),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(AppAssets.logoSplash),
          ),
          const SizedBox(
            height: 32,
          ),
          Text(
            "Santapan",
            style: TypographyStyles.semiBold(
              38,
              ColorStyles.primary,
            ),
          )
        ],
      ),
    );
  }
}
