import 'package:flutter/material.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/widget/button_custom.dart';

class BantuanPage extends StatelessWidget {
  const BantuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bantuan",
            style: TypographyStyles.bold(20, ColorStyles.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Halo! Kami di sini untuk membantu Anda.",
                style: TypographyStyles.bold(18, ColorStyles.black),
              ),
              const SizedBox(height: 8),
              Text(
                "Jika Anda memiliki pertanyaan atau masalah, Anda dapat menemukan informasi berikut:",
                style: TypographyStyles.regular(16, ColorStyles.black),
              ),
              const SizedBox(height: 24),
              Text(
                "FAQ:",
                style: TypographyStyles.bold(18, ColorStyles.black),
              ),
              const SizedBox(height: 8),
              _buildFAQItem(context, "1. Bagaimana cara membuat akun?",
                  "Anda dapat membuat akun dengan mengklik tombol 'Daftar' di halaman utama."),
              _buildFAQItem(context, "2. Bagaimana cara memulihkan kata sandi?",
                  "Ikuti langkah-langkah di halaman login untuk memulihkan kata sandi Anda."),
              _buildFAQItem(
                  context,
                  "3. Apa yang harus saya lakukan jika saya mengalami masalah saat melakukan pemesanan?",
                  "Silakan hubungi layanan pelanggan kami melalui kontak di bawah."),
              const SizedBox(height: 24),
              Text(
                "Kontak Layanan:",
                style: TypographyStyles.bold(18, ColorStyles.black),
              ),
              const SizedBox(height: 8),
              Text(
                "Email: support@santapan.com",
                style: TypographyStyles.regular(16, ColorStyles.black),
              ),
              Text(
                "Telp: +62 123 4567 890",
                style: TypographyStyles.regular(16, ColorStyles.black),
              ),
              const SizedBox(height: 24),
              ButtonCustom(
                label: "Kembali",
                onTap: () {
                  Navigator.pop(context);
                },
                isExpand: true,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFAQItem(BuildContext context, String question, String answer) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Background color white
          borderRadius: BorderRadius.circular(12), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 6,
            ),
          ], // Shadow effect
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent, // Menghilangkan garis divider
            splashColor:
                Colors.transparent, // Menghilangkan efek splash pada tile
            highlightColor: Colors.transparent, // Menghilangkan efek highlight
          ),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(
                horizontal: 16), // Padding untuk konten
            title: Text(
              question,
              style: TypographyStyles.medium(16, ColorStyles.black),
            ),
            collapsedIconColor: ColorStyles.black, // Warna ikon saat collapsed
            iconColor: ColorStyles.black, // Warna ikon saat expanded
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  answer,
                  style: TypographyStyles.regular(14, ColorStyles.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
