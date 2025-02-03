import 'package:flutter/material.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/data/urls.dart';
import 'package:santapan_fe/models/response_model.dart';
import 'package:santapan_fe/pages/personalisasi/preferensi_makanan_page.dart';
import 'package:santapan_fe/service/network.dart';
import 'package:santapan_fe/widget/button_custom.dart';
import 'package:santapan_fe/models/login_model.dart'; // Example import for model

class RiwayatPenyakitPage extends StatefulWidget {
  final bool isEdit;

  const RiwayatPenyakitPage({super.key, this.isEdit = false});

  @override
  State<RiwayatPenyakitPage> createState() => _RiwayatPenyakitPageState();
}

class _RiwayatPenyakitPageState extends State<RiwayatPenyakitPage> {
  final List<Map<String, dynamic>> diseases = [
    {'name': 'Diabetes', 'type': 'diabetes', 'selected': false},
    {'name': 'Asam Lambung/GERD', 'type': 'gerd', 'selected': false},
    {'name': 'Kolesterol', 'type': 'kolestrol', 'selected': false},
    {'name': 'Asam Urat', 'type': 'asam_urat', 'selected': false},
  ];

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                if(widget.isEdit)
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Image.asset(
                        AppAssets.arrowLeft,
                        width: 24,
                        height: 24,
                        color: widget.isEdit ? null : Colors.grey,
                      ),
                    ),
                    if (!widget.isEdit)
                      Text(
                        "Skip",
                        style: TypographyStyles.bold(16, Colors.grey),
                      ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  widget.isEdit
                      ? "Edit Riwayat Kesehatan Anda"
                      : "Personalisasi Kesehatan Anda",
                  style: TypographyStyles.bold(24, ColorStyles.black),
                ),
                const SizedBox(height: 16),
                Text(
                  "Apakah kamu punya riwayat salah satu dari kondisi berikut? Pilih yang sesuai untuk mendapatkan rekomendasi yang lebih tepat yaa...",
                  style: TypographyStyles.regular(16, ColorStyles.black),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 32),
                Container(
                  width: double.infinity,
                  height: 320,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListView.builder(
                    itemCount: diseases.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              diseases[index]['name'],
                              style: TypographyStyles.medium(14, ColorStyles.black),
                            ),
                            Checkbox(
                              value: diseases[index]['selected'],
                              activeColor: Colors.white,
                              checkColor: ColorStyles.primary,
                              onChanged: (bool? value) {
                                setState(() {
                                  diseases[index]['selected'] = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 32),
                ButtonCustom(
                  label: widget.isEdit ? "Simpan Perubahan" : "Simpan dan Lanjutkan",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PreferensiMakananPage(
                          isEdit: widget.isEdit,
                          penyakit: diseases,
                        ),
                      ),
                    );
                  },
                  isExpand: true,
                ),
                if (isLoading)
                  const Center(child: CircularProgressIndicator()),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
