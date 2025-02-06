import 'dart:async';
import 'package:flutter/material.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/data/models/menu_model.dart';
import 'package:santapan_fe/data/urls.dart';
import 'package:santapan_fe/models/response_model.dart';
import 'package:santapan_fe/pages/beranda/detail_menu_page.dart';
import 'package:santapan_fe/service/network.dart';

class SearchProductPage extends StatefulWidget {
  const SearchProductPage({super.key});

  @override
  State<SearchProductPage> createState() => _SearchProductPageState();
}

class _SearchProductPageState extends State<SearchProductPage> {
  Timer? _debounce;
  MenuModel? _menuModel;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchProducts("");
    });
  }

  Future<void> fetchProducts(String? query) async {
    final NetworkResponse response =
        await NetworkCaller().getRequest("${Urls.menuUrl}?num=8&search=${(query ?? '')}");

    if (response.isSuccess) {
      _menuModel = MenuModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to load menu data!"),
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

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      fetchProducts(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 24),
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
                        onChanged: _onSearchChanged,
                        decoration: InputDecoration(
                          hintText: 'Cari makanan kamu',
                          hintStyle:
                              TypographyStyles.medium(14, ColorStyles.black),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 14, right: 12),
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
              const SizedBox(height: 24),
              Expanded(
                child: _menuModel == null
                    ? Center(
                        child: Text(
                          'Produk tidak ditemukan.',
                          style: TypographyStyles.medium(16, Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _menuModel?.data?.menus?.length,
                        itemBuilder: (context, index) {
                          final product = _menuModel?.data?.menus?[index];
                          if(product == null) return const SizedBox();
                          
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
            builder: (context) => DetailMenuPage(
              id: id,
            ),
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
                        style:
                            TypographyStyles.semiBold(16, ColorStyles.black),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: Colors.amber, size: 20),
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
