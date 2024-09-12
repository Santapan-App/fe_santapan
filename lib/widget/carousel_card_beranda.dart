import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';

class CarouselCardBeranda extends StatefulWidget {
  const CarouselCardBeranda({super.key});

  @override
  State<CarouselCardBeranda> createState() => _CarouselCardBerandaState();
}

class _CarouselCardBerandaState extends State<CarouselCardBeranda> {
  int _currentIndex = 0;
  final List<String> images = [
    AppAssets.cardCarousel1,
    AppAssets.cardCarousel2,
    AppAssets.cardCarousel3,
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                //height: 174,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 1.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              items: images.map((imagePath) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: constraints.maxWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.contain,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: images.map((url) {
                  int index = images.indexOf(url);
                  return Container(
                    width: _currentIndex == index ? 28.0 : 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(4),
                      color: _currentIndex == index
                          ? ColorStyles.black
                          : ColorStyles.grey,
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
