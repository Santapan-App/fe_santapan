import 'package:flutter/material.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';

class SearchArtikelPage extends StatefulWidget {
  const SearchArtikelPage({super.key});

  @override
  State<SearchArtikelPage> createState() => _SearchArtikelPageState();
}

class _SearchArtikelPageState extends State<SearchArtikelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      AppAssets.arrowLeft,
                      width: 24,
                      height: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                      ),
                      child: TextField(
                        onTap: () {},
                        decoration: InputDecoration(
                          hintText: 'Cari Artikel',
                          hintStyle:
                              TypographyStyles.medium(14, ColorStyles.black),
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
