import 'package:flutter/material.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/data/models/article_model.dart';
import 'package:santapan_fe/data/urls.dart';
import 'package:santapan_fe/models/response_model.dart';
import 'package:santapan_fe/pages/artikel/detail_artikel_page.dart';
import 'package:santapan_fe/pages/artikel/search_artikel_page.dart';
import 'package:santapan_fe/service/network.dart';

class ArtikelPage extends StatefulWidget {
  const ArtikelPage({super.key});

  @override
  State<ArtikelPage> createState() => _ArtikelPageState();
}

class _ArtikelPageState extends State<ArtikelPage> {
    bool isLoading = false;
    ArticleModel? _articleModel = ArticleModel();

    Future<void> getCategories() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.articleUrl + "?num=8");

    if (response.isSuccess) {
      _articleModel = ArticleModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to load data!"),
          ),
        );
      }
    }
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            "Artikel",
            style: TypographyStyles.semiBold(24, ColorStyles.black),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 24,
                ),
                searhField(),
                const SizedBox(
                  height: 24,
                ),
                bannerArtikel(),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DetailArtikelPage()));
                  },
                  child: listArtikel(
                    context,
                    "https://picsum.photos/200/300",
                    "Mengatasi Hipertensi dengan Pola Makan yang Tepat",
                    "12 Maret 2024",
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                listArtikel(
                  context,
                  "https://picsum.photos/200/300",
                  "Tips ips Pola Makan untuk Mengurangi Risiko Diabetes",
                  "13 Maret 2024",
                ),
                const SizedBox(
                  height: 12,
                ),
                listArtikel(
                  context,
                  "https://picsum.photos/200/300",
                  "Tips ips Pola Makan untuk Mengurangi Risiko Diabetes",
                  "13 Maret 2024",
                ),
                const SizedBox(
                  height: 12,
                ),
                listArtikel(
                  context,
                  "https://picsum.photos/200/300",
                  "Tips ips Pola Makan untuk Mengurangi Risiko Diabetes",
                  "13 Maret 2024",
                ),
                const SizedBox(
                  height: 12,
                ),
                listArtikel(
                  context,
                  "https://picsum.photos/200/300",
                  "Tips ips Pola Makan untuk Mengurangi Risiko Diabetes",
                  "13 Maret 2024",
                ),
                const SizedBox(
                  height: 12,
                ),
                listArtikel(
                  context,
                  "https://picsum.photos/200/300",
                  "Tips ips Pola Makan untuk Mengurangi Risiko Diabetes",
                  "13 Maret 2024",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container listArtikel(
      BuildContext context, String image, String title, String date) {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey[300],
            ),
            clipBehavior: Clip.hardEdge,
            child: Image.network(
              image,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TypographyStyles.semiBold(14, ColorStyles.black),
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.visible,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.date_range_outlined,
                        color: ColorStyles.grey, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      date,
                      style: TypographyStyles.regular(12, ColorStyles.grey),
                      textAlign: TextAlign.start,
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

  Container bannerArtikel() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.hardEdge,
      child: Image.asset(
        AppAssets.bannerArtikel,
        fit: BoxFit.cover,
      ),
    );
  }

  Container searhField() {
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
            MaterialPageRoute(builder: (context) => const SearchArtikelPage()),
          );
        },
        child: AbsorbPointer(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Cari Artikel',
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
}
