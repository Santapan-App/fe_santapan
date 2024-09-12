import 'package:flutter/material.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/widget/button_custom.dart';

class DetailStatusPesananPage extends StatefulWidget {
  const DetailStatusPesananPage({super.key});

  @override
  State<DetailStatusPesananPage> createState() =>
      _DetailStatusPesananPageState();
}

class _DetailStatusPesananPageState extends State<DetailStatusPesananPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Detail Status Pesanan",
          style: TypographyStyles.bold(24, ColorStyles.black),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorStyles.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0XFFEDEDED)),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Terimakasih ",
                                      style: TypographyStyles.bold(
                                          16, ColorStyles.black),
                                    ),
                                    TextSpan(
                                      text: "#sobatSantapan",
                                      style: TypographyStyles.bold(
                                          16, ColorStyles.primary),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Selamat menikmati hidangan sehatmu\nbersama Santapan! Sehat selalu, ya!",
                                style: TypographyStyles.medium(
                                    12, ColorStyles.grey),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Image.asset(
                          AppAssets.pesananSukses,
                          width: 56,
                          height: 56,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Text(
                          "Order ID: ",
                          style:
                              TypographyStyles.regular(12, ColorStyles.black),
                        ),
                        Text(
                          "123456789",
                          style: TypographyStyles.medium(12, ColorStyles.black),
                        )
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          "Tanggal: ",
                          style:
                              TypographyStyles.regular(12, ColorStyles.black),
                        ),
                        Text(
                          "07 Maret 2024 | 14:07",
                          style: TypographyStyles.medium(12, ColorStyles.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              alamatInfo(),
              const SizedBox(
                height: 16,
              ),
              daftarPesanan(),
              const SizedBox(
                height: 16,
              ),
              detailPesanan(context),
              const SizedBox(
                height: 24,
              ),
              ButtonCustom(
                label: "Pesan ulang",
                onTap: () {},
                isExpand: true,
              )
            ],
          ),
        ),
      ),
    );
  }

  Container detailPesanan(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0XFFEDEDED)),
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Detail Pesanan",
            style: TypographyStyles.semiBold(16, ColorStyles.black),
          ),
          const SizedBox(
            height: 10,
          ),
          itemDetailPesanan(context, "Subtotal", "Rp 45.000"),
          const SizedBox(
            height: 10,
          ),
          itemDetailPesanan(context, "Pengiriman", "Rp 100.000"),
          const SizedBox(
            height: 10,
          ),
          itemDetailPesanan(context, "Total", "Rp 100.000"),
        ],
      ),
    );
  }

  Row itemDetailPesanan(BuildContext context, String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TypographyStyles.medium(14, ColorStyles.black),
        ),
        Text(
          value,
          style: TypographyStyles.medium(14, ColorStyles.black),
        ),
      ],
    );
  }

  Container daftarPesanan() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0XFFEDEDED)),
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Daftar Pesanan",
            style: TypographyStyles.semiBold(16, ColorStyles.black),
          ),
          const SizedBox(
            height: 12,
          ),
          itemPesanan(),
          const SizedBox(
            height: 12,
          ),
          itemPesanan(),
        ],
      ),
    );
  }

  Container itemPesanan() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              "https://picsum.photos/200/300",
              width: 54,
              height: 54,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "1x ",
                      style: TypographyStyles.semiBold(14, ColorStyles.black),
                    ),
                    Text(
                      "Nama makanan",
                      style: TypographyStyles.semiBold(14, ColorStyles.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  "Rp 20,000",
                  style: TypographyStyles.regular(12, ColorStyles.grey),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container alamatInfo() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0XFFEDEDED)),
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                AppAssets.paymentAlamat,
                width: 42,
                height: 42,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Santapan",
                    style: TypographyStyles.semiBold(14, ColorStyles.black),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Santapan, Bandung",
                    style: TypographyStyles.regular(12, ColorStyles.grey),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              children: List.generate(
                  3,
                  (index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Container(
                          width: 4,
                          height: 4,
                          decoration: const BoxDecoration(
                            color: Color(0xFF1C1C1C),
                            shape: BoxShape.circle,
                          ),
                        ),
                      )),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                AppAssets.paymentDestination,
                width: 42,
                height: 42,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pengantaran",
                      style: TypographyStyles.semiBold(14, ColorStyles.black),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Jl Hj Umayah II, Kota Bandung",
                      style: TypographyStyles.regular(12, ColorStyles.grey),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Notes section
          Text(
            "Notes:",
            style: TypographyStyles.semiBold(14, ColorStyles.black),
          ),
        ],
      ),
    );
  }
}
