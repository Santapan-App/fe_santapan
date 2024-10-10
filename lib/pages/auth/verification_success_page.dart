import 'package:flutter/material.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/pages/auth/signin_page.dart';
import 'package:santapan_fe/widget/button_custom.dart';

class VerificationSuccessPage extends StatelessWidget {
  const VerificationSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppAssets.verif,
              ),
              const SizedBox(height: 32),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Hore! Pendaftaran akun ",
                  style: TypographyStyles.semiBold(16, ColorStyles.black),
                  children: [
                    TextSpan(
                      text: "#sobatSantapan",
                      style: TypographyStyles.semiBold(16, ColorStyles.primary),
                    ),
                    TextSpan(
                      text: " Berhasil!",
                      style: TypographyStyles.semiBold(16, ColorStyles.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Temukan makanan yang sesuai dengan gaya hidup sehatmu.",
                style: TypographyStyles.medium(14, ColorStyles.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 42),
              ButtonCustom(
                label: "Login sekarang",
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SigninPage()));
                },
                isExpand: false,
              )
            ],
          ),
        ),
      ),
    );
  }
}
