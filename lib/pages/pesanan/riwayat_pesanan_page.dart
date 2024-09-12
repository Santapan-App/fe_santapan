import 'package:flutter/material.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/pages/pesanan/detail_status_pesanan_page.dart';
import 'package:santapan_fe/pages/pesanan/ulasan_page.dart';
import 'package:santapan_fe/widget/button_pesanan.dart';

class RiwayatPesananPage extends StatefulWidget {
  const RiwayatPesananPage({super.key});

  @override
  State<RiwayatPesananPage> createState() => _RiwayatPesananPageState();
}

class _RiwayatPesananPageState extends State<RiwayatPesananPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            cardPesananDibatalkan(),
            const SizedBox(
              height: 12,
            ),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const DetailStatusPesananPage()));
                },
                child: cardPesananSelesai())
          ],
        ),
      ),
    );
  }

  Container cardPesananSelesai() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "20/03/2020",
                style: TypographyStyles.regular(14, ColorStyles.grey),
              ),
              Text(
                "Selesai",
                style: TypographyStyles.medium(16, ColorStyles.primary),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Image.asset(
                AppAssets.imagePesanan,
                width: 40,
                height: 40,
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Text(
                  "Menu 1, Menu 2, Menu 3, Banyak order makanan 123456789",
                  style: TypographyStyles.semiBold(
                    14,
                    ColorStyles.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Harga",
                style: TypographyStyles.medium(14, ColorStyles.black),
              ),
              Text("Rp40.000",
                  style: TypographyStyles.bold(14, ColorStyles.black))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ButtonPesanan(
                label: "Beli lagi",
                borderColor: const Color(0xFF777777),
                textStyle:
                    TypographyStyles.regular(14, const Color(0xFF737373)),
                width: 90,
                onPressed: () {},
              ),
              const SizedBox(
                width: 12,
              ),
              ButtonPesanan(
                label: "Nilai",
                borderColor: ColorStyles.primary,
                textStyle: TypographyStyles.medium(14, ColorStyles.primary),
                width: 69,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UlasanPage(),
                    ),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Container cardPesananDibatalkan() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "20/03/2020",
                style: TypographyStyles.regular(14, ColorStyles.grey),
              ),
              Text(
                "Dibatalkan",
                style: TypographyStyles.medium(16, ColorStyles.primary),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Image.asset(
                AppAssets.imagePesanan,
                width: 40,
                height: 40,
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Text(
                  "Menu 1, Menu 2, Menu 3, Banyak order makanan 123456789",
                  style: TypographyStyles.semiBold(
                    14,
                    ColorStyles.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Harga",
                style: TypographyStyles.medium(14, ColorStyles.black),
              ),
              Text("Rp40.000",
                  style: TypographyStyles.bold(14, ColorStyles.black))
            ],
          ),
        ],
      ),
    );
  }
}
