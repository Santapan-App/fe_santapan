import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/pages/pesanan/pesanan_saat_ini_page.dart';
import 'package:santapan_fe/pages/pesanan/riwayat_pesanan_page.dart';

class PesananPage extends StatefulWidget {
  const PesananPage({super.key});

  @override
  State<PesananPage> createState() => _PesananPageState();
}

class _PesananPageState extends State<PesananPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              "Pesanan",
              style: TypographyStyles.semiBold(24, ColorStyles.black),
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text(
                  "Pesanan Saat Ini",
                  style: GoogleFonts.plusJakartaSans(),
                ),
              ),
              Tab(
                child: Text(
                  "Riwayat Pesanan",
                  style: GoogleFonts.plusJakartaSans(),
                ),
              ),
            ],
            labelColor: ColorStyles.primary,
            unselectedLabelColor: ColorStyles.black,
            indicatorColor: ColorStyles.primary,
          ),
        ),
        body: TabBarView(
          children: [
            PesananSaatIniPage(),
            RiwayatPesananPage(),
          ],
        ),
      ),
    );
  }
}
