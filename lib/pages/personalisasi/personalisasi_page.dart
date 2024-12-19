import 'package:flutter/material.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/pages/personalisasi/riwayat_penyakit_page.dart';
import 'package:santapan_fe/widget/button_custom.dart';

class PersonalisasiPage extends StatefulWidget {
  const PersonalisasiPage({super.key});

  @override
  State<PersonalisasiPage> createState() => _PersonalisasiPageState();
}

class _PersonalisasiPageState extends State<PersonalisasiPage> {
  final List<Map<String, dynamic>> selectedDiseases = [
    {'name': 'Diabetes', 'selected': true},
    {'name': 'Kolesterol', 'selected': false},
  ];

  final List<Map<String, dynamic>> selectedPreferences = [
    {'name': 'Rendah Karbohidrat', 'selected': true},
    {'name': 'Vegetarian', 'selected': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Personalisasi",
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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  "Personalisasi Kamu",
                  style: TypographyStyles.bold(20, ColorStyles.black),
                ),
                const SizedBox(height: 8),
                Text(
                  "Berikut adalah preferensi kesehatan dan makananmu",
                  style: TypographyStyles.regular(14, ColorStyles.black),
                ),
                const SizedBox(height: 24),
                _buildSectionWithContainer("Riwayat Penyakit",
                    AppAssets.heartDiagnosa, selectedDiseases),
                const SizedBox(height: 24),
                _buildSectionWithContainer("Preferensi Makanan",
                    AppAssets.preferensiMakan, selectedPreferences),
                const SizedBox(height: 32),
                ButtonCustom(
                  label: "Ubah Personalisasi",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RiwayatPenyakitPage(),
                      ),
                    );
                  },
                  isExpand: true,
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget for section title and items in a container
  Widget _buildSectionWithContainer(
      String title, String icon, List<Map<String, dynamic>> items) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                icon,
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TypographyStyles.semiBold(18, ColorStyles.black),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...items
              .where((item) => item['selected'])
              .map((item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      item['name'],
                      style: TypographyStyles.medium(16, ColorStyles.black),
                    ),
                  ))
              ,
        ],
      ),
    );
  }
}
