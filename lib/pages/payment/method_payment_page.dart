import 'package:flutter/material.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/widget/button_custom.dart';

class MethodPaymentPage extends StatefulWidget {
  const MethodPaymentPage({super.key});

  @override
  State<MethodPaymentPage> createState() => _MethodPaymentPageState();
}

class _MethodPaymentPageState extends State<MethodPaymentPage> {
  int _selectedMethod = 0;

  final List<Map<String, String>> _paymentMethods = [
    {"name": "Dana", "image": AppAssets.danaImage},
    {"name": "Midtrans", "image": AppAssets.midtransImage},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorStyles.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            totalPembayaran(),
            const SizedBox(
              height: 24,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pilih metode pembayaran",
                    style: TypographyStyles.bold(16, ColorStyles.black),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Column(
                    children: List.generate(_paymentMethods.length, (index) {
                      return Container(
                        width: double.infinity,
                        height: 70,
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: const Color(0XFFE1E1E1)),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  _paymentMethods[index]["image"]!,
                                  width: 32,
                                  height: 32,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  _paymentMethods[index]["name"]!,
                                  style:
                                      TypographyStyles.bold(14, Colors.black),
                                ),
                              ],
                            ),
                            Radio<int>(
                              value: index,
                              groupValue: _selectedMethod,
                              onChanged: (int? value) {
                                setState(() {
                                  _selectedMethod = value!;
                                });
                              },
                              activeColor: ColorStyles.primary,
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: ButtonCustom(
                label: "Bayar sekarang",
                onTap: () {
                  // Aksi ketika tombol diklik
                },
                isExpand: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container totalPembayaran() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Total Pembayaran:",
            style: TypographyStyles.medium(16, ColorStyles.grey),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            "RP.999999.99",
            style: TypographyStyles.bold(20, ColorStyles.black),
          )
        ],
      ),
    );
  }
}
