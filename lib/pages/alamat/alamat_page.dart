import 'package:flutter/material.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/pages/alamat/tambah_alamat_page.dart';
import 'package:santapan_fe/widget/button_custom.dart';

class AlamatPage extends StatefulWidget {
  const AlamatPage({super.key});

  @override
  State<AlamatPage> createState() => _AlamatPageState();
}

class _AlamatPageState extends State<AlamatPage> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Alamat",
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
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ListView(
              children: [
                const SizedBox(
                  height: 24,
                ),
                cardAlamat(0),
                const SizedBox(
                  height: 12,
                ),
                cardAlamat(1),
              ],
            ),
          ),
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.transparent,
              child: ButtonCustom(
                label: "Tambah Alamat",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TambahAlamatPage()));
                },
                isExpand: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget cardAlamat(int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: isSelected
              ? Border.all(color: ColorStyles.primary, width: 2)
              : null,
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Label Alamat",
                    style: TypographyStyles.bold(16, Colors.black),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Jalan H. Umayah II No.1, Citereup, Bandung Regency",
                    style: TypographyStyles.regular(14, ColorStyles.grey),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Palnazhmi",
                        style: TypographyStyles.semiBold(12, ColorStyles.black),
                        overflow: TextOverflow.clip,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        "628723727549",
                        style: TypographyStyles.medium(12, ColorStyles.grey),
                      ),
                    ],
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
      ),
    );
  }
}
