import 'package:flutter/material.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';

class PesananSaatIniPage extends StatefulWidget {
  const PesananSaatIniPage({super.key});

  @override
  State<PesananSaatIniPage> createState() => _PesananSaatIniPageState();
}

class _PesananSaatIniPageState extends State<PesananSaatIniPage> {
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
            Container(
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
                        "Proses",
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
