import 'package:flutter/material.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/pages/beranda/search_product_page.dart';
import 'package:santapan_fe/pages/berlangganan/langganan_bulanan_page.dart';
import 'package:santapan_fe/pages/berlangganan/langganan_mingguan_page.dart';
import 'package:santapan_fe/widget/carousel_card_beranda.dart';
import 'package:santapan_fe/widget/categories_food.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SizedBox(
            //   height: 42,
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: header(),
            ),
            const SizedBox(
              height: 4,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: CarouselCardBeranda(),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: searchField(),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Kategori",
                style: TypographyStyles.bold(16, ColorStyles.black),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CategoriesFood(
                      image: AppAssets.indonesiaCategories, text: "Indonesia"),
                  CategoriesFood(
                      image: AppAssets.westernCategories, text: "Western"),
                  CategoriesFood(
                      image: AppAssets.japaneseCategories, text: "Jepang"),
                  CategoriesFood(
                      image: AppAssets.koreanCategories, text: "Korea"),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Paket Langganan",
                style: TypographyStyles.bold(16, ColorStyles.black),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: langgananPaket(),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Rekomendasi",
                      style: TypographyStyles.bold(16, ColorStyles.black)),
                  Text("Lihat semua",
                      style: TypographyStyles.semiBold(14, ColorStyles.black)),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 0),
              child: SizedBox(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    menuTitleHorizontal(),
                    const SizedBox(width: 16),
                    itemMenuKatalog(),
                    const SizedBox(width: 16),
                    itemMenuKatalog(),
                    const SizedBox(width: 16),
                    itemMenuKatalog(),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 56,
            ),
          ],
        ),
      ),
    );
  }

  Container menuTitleHorizontal() {
    return Container(
      width: 156,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.hardEdge,
      child: Image.asset(
        AppAssets.katalogImage,
        fit: BoxFit.cover,
      ),
    );
  }

  Container itemMenuKatalog() {
    return Container(
      width: 156,
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0XFFE1E1E1)),
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              "https://picsum.photos/id/237/200/300",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nama Menu",
                  style: TypographyStyles.medium(12, ColorStyles.black),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      "Rp.20.000",
                      style: TypographyStyles.bold(12, ColorStyles.black),
                    ),
                    const Spacer(),
                    const Icon(Icons.star, color: ColorStyles.warning),
                    Text(
                      "4.9",
                      style: TypographyStyles.medium(12, ColorStyles.warning),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row langgananPaket() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LanggananMingguanPage(),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(12),
              clipBehavior: Clip.hardEdge,
              child: Image.asset(
                AppAssets.langgananMingguan,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LanggananBulananPage(),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(12),
              clipBehavior: Clip.hardEdge,
              child: Image.asset(
                AppAssets.langgananBulanan,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Container searchField() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SearchProductPage()),
          );
        },
        child: AbsorbPointer(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Cari makanan kamu',
              hintStyle: TypographyStyles.medium(14, ColorStyles.black),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(
                  left: 14,
                  right: 12,
                ),
                child: Image.asset(
                  AppAssets.searchIcon,
                  width: 24,
                  height: 24,
                ),
              ),
              border: InputBorder.none,
              prefixIconConstraints: const BoxConstraints(
                minWidth: 12,
                minHeight: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          AppAssets.berandaLogo,
          width: 138,
          height: 45,
        ),
        Image.asset(
          AppAssets.notif,
          width: 40,
          height: 40,
        ),
      ],
    );
  }
}
