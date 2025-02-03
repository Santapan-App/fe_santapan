import 'package:flutter/material.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';

class DetailArtikelPage extends StatelessWidget {
  final String title;
  final String date;
  final String imageUrl;
  final String content;

  const DetailArtikelPage({
    super.key,
    required this.title,
    required this.date,
    required this.imageUrl,
    required this.content,
  });

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
                  child: Image.asset(AppAssets.arrowLeft, width: 24, height: 24)),
              const SizedBox(
                height: 24,
              ),
              Text(
                title, // Use the dynamic title passed to the page
                style: TypographyStyles.semiBold(16, ColorStyles.black),
                overflow: TextOverflow.visible,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                date, // Use the dynamic date passed to the page
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
                  imageUrl, // Use the dynamic image URL passed to the page
                  width: double.infinity,
                  height: 214,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                content, // Use the dynamic content passed to the page
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
