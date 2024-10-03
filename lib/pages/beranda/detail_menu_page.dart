import 'package:flutter/material.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/pages/beranda/nutrisi_info.dart';
import 'package:santapan_fe/widget/button_custom.dart';

class DetailMenuPage extends StatefulWidget {
  const DetailMenuPage({super.key});

  @override
  State<DetailMenuPage> createState() => _DetailMenuPageState();
}

class _DetailMenuPageState extends State<DetailMenuPage> {
  int quantity = 1;
  final double pricePerItem = 50000;
  double get totalPrice => pricePerItem * quantity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  imageMenu(context),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nama Menu",
                          style: TypographyStyles.bold(20, ColorStyles.black),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Rp ${pricePerItem.toString()}",
                          style:
                              TypographyStyles.semiBold(16, ColorStyles.black),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Ini adalah deskripsi menu yang sangat enak dan sehat. Cocok untuk diet dan memenuhi kebutuhan nutrisi harian Anda.",
                          style:
                              TypographyStyles.regular(16, ColorStyles.black),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.check_circle,
                              size: 24,
                              color: ColorStyles.success,
                            ),
                            const SizedBox(width: 12),
                            Flexible(
                              child: Text(
                                "Cocok untuk penderita diabetes.",
                                style: TypographyStyles.regular(
                                    16, ColorStyles.black),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        notes(),
                        const SizedBox(height: 12),
                        NutrisiInfo(),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Ulasan",
                              style:
                                  TypographyStyles.bold(16, ColorStyles.black),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "Lihat Semua",
                                style: TypographyStyles.regular(
                                    12, ColorStyles.primary),
                              ),
                            ),
                          ],
                        ),
                        ulasanUser(),
                        const SizedBox(height: 8),
                        ulasanUser(),
                        const SizedBox(height: 8),
                        ulasanUser(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Harga",
                              style: TypographyStyles.semiBold(
                                  14, ColorStyles.grey),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Rp ${totalPrice.toString()}",
                              style:
                                  TypographyStyles.bold(16, ColorStyles.black),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (quantity > 1) {
                                    quantity--;
                                  }
                                });
                              },
                              child: Image.asset(
                                AppAssets.iconMinus,
                                width: 24,
                                height: 24,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "$quantity",
                              style:
                                  TypographyStyles.bold(16, ColorStyles.black),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                              child: Image.asset(
                                AppAssets.iconPlus,
                                width: 24,
                                height: 24,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    ButtonCustom(
                      label: "Tambah ke Keranjang",
                      onTap: () {
                        // Handle add to cart logic
                      },
                      isExpand: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox ulasanUser() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                AppAssets.profileIcon,
                width: 36,
                height: 36,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nama User",
                      style: TypographyStyles.bold(12, ColorStyles.black),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: List.generate(
                        5,
                        (index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse convallis.",
                      style: TypographyStyles.regular(12, ColorStyles.black),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container notes() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Notes: ",
                      style: TypographyStyles.bold(16, ColorStyles.black),
                    ),
                    TextSpan(
                      text: "(Optional)",
                      style: TypographyStyles.regular(16, ColorStyles.black),
                    ),
                  ],
                ),
              ),
              Image.asset(
                AppAssets.editIcon,
                width: 24,
                height: 24,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "Contoh: packing rapi, jangan pakai sambal, di pisah saus nya.",
            style: TypographyStyles.regular(14, const Color(0xFF7A7A7A)),
          ),
        ],
      ),
    );
  }

  Stack imageMenu(BuildContext context) {
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
          top: 16,
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
