import 'package:flutter/material.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/pages/beranda/detail_menu_page.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  // Daftar data makanan
  final List<Map<String, dynamic>> foodList = [
    {
      "name": "Nama Makanan 1",
      "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      "price": "Rp40.000",
      "rating": 4.5,
      "imageUrl": "https://picsum.photos/200/300?1"
    },
    {
      "name": "Nama Makanan 2",
      "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      "price": "Rp50.000",
      "rating": 4.0,
      "imageUrl": "https://picsum.photos/200/300?2"
    },
    {
      "name": "Nama Makanan 3",
      "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      "price": "Rp60.000",
      "rating": 5.0,
      "imageUrl": "https://picsum.photos/200/300?3"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Nama Kategori",
          style: TypographyStyles.bold(24, ColorStyles.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorStyles.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView.builder(
          itemCount: foodList.length,
          itemBuilder: (context, index) {
            final food = foodList[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: itemMenuMakan(
                food['name'],
                food['description'],
                food['price'],
                food['rating'],
                food['imageUrl'],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget itemMenuMakan(String name, String description, String price,
      double rating, String imageUrl) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const DetailMenuPage()));
      },
      child: Container(
        padding: const EdgeInsets.all(12),
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
                width: 80,
                height: 80,
                fit: BoxFit.cover,
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
                        price,
                        style: TypographyStyles.semiBold(16, ColorStyles.black),
                      ),
                      const SizedBox(width: 16),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            rating.toString(),
                            style: TypographyStyles.regular(14, Colors.black),
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
