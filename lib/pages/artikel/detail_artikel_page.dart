import 'package:flutter/material.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';

class DetailArtikelPage extends StatelessWidget {
  const DetailArtikelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child:
                      Image.asset(AppAssets.arrowLeft, width: 24, height: 24)),
              const SizedBox(
                height: 24,
              ),
              Text(
                "Mengatasi Hipertensi dengan Pola Makan yang Tepat",
                style: TypographyStyles.semiBold(16, ColorStyles.black),
                overflow: TextOverflow.visible,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "12 Maret 2024",
                style: TypographyStyles.medium(12, ColorStyles.grey),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.network(
                  "https://picsum.photos/200/300",
                  width: double.infinity,
                  height: 214,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                style: TypographyStyles.medium(12, ColorStyles.black),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
