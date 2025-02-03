import 'dart:io';

import 'package:flutter/material.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/data/models/menu_model.dart';
import 'package:santapan_fe/data/models/nutrition_model.dart';
import 'package:santapan_fe/data/urls.dart';
import 'package:santapan_fe/models/response_model.dart';
import 'package:santapan_fe/pages/beranda/detail_menu_page.dart';
import 'package:santapan_fe/pages/navbar.dart';
import 'package:santapan_fe/pages/scan/nutrisi_result.dart';
import 'package:santapan_fe/service/network.dart';
import 'package:santapan_fe/widget/button_custom.dart';

class ScanResultPage extends StatefulWidget {
  final String prediction;
  final String accuracy;
  final File image;

  const ScanResultPage({
    super.key,
    required this.prediction,
    required this.accuracy,
    required this.image,
  });

  @override
  State<ScanResultPage> createState() => _ScanResultPageState();
}

class _ScanResultPageState extends State<ScanResultPage> {
  bool isLoading = false;
  NutritionModel? _nutritionModel;
  String? errorMessage;
  MenuModel? _menuModel;  // Added to hold the recommended menu data

  @override
  void initState() {
    super.initState();
    getNutritionData();
    fetchRecommendedMenus();
  }

  Future<void> getNutritionData() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    // Fetch nutrition data based on prediction
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.nutritionUrl + "?classification=" + widget.prediction);

    if (response.isSuccess) {
      setState(() {
        _nutritionModel = NutritionModel.fromJson(response.body!);
      });
    } else {
      setState(() {
        errorMessage = "Failed to load data!";
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load data!")),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchRecommendedMenus() async {
    // Replace this with your actual API endpoint or logic to fetch recommended menus
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.menuUrl + "/food-nutrition?food_name=${widget.prediction}");

    if (response.isSuccess) {
      setState(() {
        _menuModel = MenuModel.fromJson(response.body!);
      });
    } else {
      setState(() {
        errorMessage = "Failed to load recommended menus!";
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load recommended menus!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button and Title
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(
                      AppAssets.leftRoundedIcon,
                      width: 32,
                      height: 32,
                    ),
                  ),
                  const SizedBox(width: 65),
                  Center(
                    child: Text(
                      "Hasil Rekomendasi",
                      style: TypographyStyles.semiBold(20, ColorStyles.black),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Image and Prediction Info
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.file(
                      widget.image,
                      width: 220,
                      height: 220,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.prediction,
                          style: TypographyStyles.semiBold(16, Colors.black),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Confident: ${widget.accuracy}",
                          style: TypographyStyles.regular(14, Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),
              // Show Loading, Error, or NutrisiResult
              if (isLoading)
                const Center(child: CircularProgressIndicator())
              else if (errorMessage != null)
                Center(child: Text(errorMessage!, style: TypographyStyles.regular(14, Colors.red)))
              else if (_nutritionModel != null)
                NutrisiResult(
                  nutrisiList: [
                    Nutrisi(label: 'Karbo', value: _nutritionModel!.carbohydrates.toString(), satuan: 'g'),
                    Nutrisi(label: 'Protein', value: _nutritionModel!.protein.toString(), satuan: 'g'),
                    Nutrisi(label: 'Kalori', value: _nutritionModel!.calories.toString(), satuan: 'kcal'),
                    Nutrisi(label: 'Gula', value: _nutritionModel!.sugar.toString(), satuan: 'g'),
                    Nutrisi(label: 'Fat', value: _nutritionModel!.fat.toString(), satuan: 'g'),
                  ],
                ),

              const SizedBox(height: 20),

              // Recommendation Section
              Text("Rekomendasi Hidangan", style: TypographyStyles.bold(16, ColorStyles.black)),
              Text(
                "Hidangan berikut cocok dengan makanan yang kamu scan!",
                style: TypographyStyles.bold(14, ColorStyles.grey),
              ),

              const SizedBox(height: 20),
              // Display Recommended Menus
              _menuModel == null
                  ? Center(child: Text('Produk tidak ditemukan.', style: TypographyStyles.medium(16, Colors.grey)))
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _menuModel?.data?.menus?.length ?? 0,
                      itemBuilder: (context, index) {
                        final product = _menuModel?.data?.menus?[index];
                        if (product == null) return const SizedBox();

                        return _buildMenuItem(
                          id: product.id ?? 0,
                          name: product.title ?? '',
                          description: product.description ?? '',
                          price: (product.price ?? 0).toString(),
                          rating: 4.5,
                          imageUrl: product.image ?? '',
                        );
                      },
                    ),

              const SizedBox(height: 20),

              // Back to Home Button
              ButtonCustom(
                label: "Kembali ke Beranda",
                onTap: () {
                  Navigator.pop(context);
                },
                isExpand: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required int id,
    required String name,
    required String description,
    required String price,
    required double rating,
    required String imageUrl,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailMenuPage(id: id),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image, size: 100),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TypographyStyles.semiBold(16, Colors.black),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TypographyStyles.regular(14, Colors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        'Rp$price',
                        style: TypographyStyles.semiBold(16, ColorStyles.black),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            rating.toStringAsFixed(1),
                            style: TypographyStyles.bold(14, Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
