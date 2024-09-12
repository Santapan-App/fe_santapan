import 'package:flutter/material.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/pages/auth/signin_page.dart';
import 'package:santapan_fe/widget/button_custom.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.bgScreen,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  _buildPage(
                    context,
                    image: AppAssets.onboard1,
                    title: "Selamat Datang di Santapan",
                    description:
                        "Makanan yang dipersonalisasi untuk kondisi kesehatanmu.",
                    buttonLabel: "Lanjutkan",
                    buttonAction: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                  _buildPage(
                    context,
                    image: AppAssets.onboard2,
                    title: "Tentukan Perjalanan Sehat",
                    description:
                        "Identifikasi produk kemasan dan makanan yang cocok untukmu.",
                    buttonLabel: "Lanjutkan",
                    buttonAction: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                  _buildPage(
                    context,
                    image: AppAssets.onboard3,
                    title: "Santap Sehat Tanpa Repot",
                    description:
                        "Hemat waktu dengan langganan katering makanan diantar langsung.",
                    buttonLabel: "Mulai sekarang",
                    buttonAction: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SigninPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            _buildPageIndicator(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(
    BuildContext context, {
    required String image,
    required String title,
    required String description,
    required String buttonLabel,
    required VoidCallback buttonAction,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: TypographyStyles.bold(22, ColorStyles.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                description,
                style: TypographyStyles.medium(14, ColorStyles.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ButtonCustom(
                label: buttonLabel,
                onTap: buttonAction,
                isExpand: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          height: 8.0,
          width: _currentPage == index ? 24.0 : 8.0,
          decoration: BoxDecoration(
            color: _currentPage == index ? ColorStyles.black : ColorStyles.grey,
            borderRadius: BorderRadius.circular(12),
          ),
        );
      }),
    );
  }
}
