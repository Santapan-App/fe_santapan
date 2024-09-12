import 'package:flutter/material.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/widget/button_custom.dart';

class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppAssets.successPayment,
                width: 268,
                height: 271,
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                "Pembayaran Berhasil!",
                style: TypographyStyles.bold(20, ColorStyles.black),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Nikmati perjalanan lebih sehat kamu di Santapan. ",
                style: TypographyStyles.medium(14, ColorStyles.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 32,
              ),
              ButtonCustom(
                label: "Lihat pesanan",
                onTap: () {},
                isExpand: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
