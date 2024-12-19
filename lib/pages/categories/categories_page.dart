import 'package:flutter/material.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/data/models/menu_category_model.dart';
import 'package:santapan_fe/data/urls.dart';
import 'package:santapan_fe/pages/beranda/detail_menu_page.dart';
import 'package:santapan_fe/service/network.dart';

class CategoriesPage extends StatefulWidget {
  final String id;
  final String title;

  const CategoriesPage({super.key, required this.id, required this.title});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  late MenuCategoryModel _menuModel;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _menuModel = MenuCategoryModel(); // Initialize an empty model
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchMenu();
    });
  }

  Future<void> _fetchMenu() async {
    setState(() => _isLoading = true);

    final response = await NetworkCaller().getRequest('${Urls.menuUrl}/category/${widget.id}');
    if (response.isSuccess) {
      setState(() {
        _menuModel = MenuCategoryModel.fromJson(response.body ?? {});
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load menu data!')),
      );
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TypographyStyles.bold(24, ColorStyles.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorStyles.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _menuModel.data?.isEmpty ?? true
              ? const Center(child: Text('No menus available'))
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: ListView.builder(
                    itemCount: _menuModel.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      final menu = _menuModel.data![index];
                      return _buildMenuItem(
                        name: menu.title ?? '',
                        description: menu.description ?? '',
                        price: menu.price?.toString() ?? '',
                        rating: 4.5,
                        imageUrl: menu.imageUrl ?? '',
                      );
                    },
                  ),
              )
    );
  }

  Widget _buildMenuItem({
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
            builder: (context) => const DetailMenuPage(
              id: 1
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: EdgeInsets.only(bottom: 20),
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
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 100),
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
