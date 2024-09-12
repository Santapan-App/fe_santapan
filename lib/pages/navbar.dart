import 'package:flutter/material.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/pages/artikel/artikel_page.dart';
import 'package:santapan_fe/pages/beranda/beranda_page.dart';
import 'package:santapan_fe/pages/pesanan/pesanan_page.dart';
import 'package:santapan_fe/pages/scan/scan_page.dart';
import 'package:santapan_fe/pages/akun/akun_page.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onItemTapped(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                BerandaPage(),
                PesananPage(),
                ScanPage(),
                ArtikelPage(),
                AkunPage(),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 95,
                margin:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: BottomNavigationBar(
                    showSelectedLabels: true,
                    showUnselectedLabels: true,
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    type: BottomNavigationBarType.fixed,
                    currentIndex: _currentIndex,
                    onTap: _onItemTapped,
                    selectedItemColor: Colors.black,
                    unselectedItemColor: Colors.grey,
                    selectedLabelStyle:
                        TypographyStyles.semiBold(12, Colors.black),
                    unselectedLabelStyle:
                        TypographyStyles.regular(12, Colors.grey),
                    items: [
                      BottomNavigationBarItem(
                        icon: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppAssets.berandaUnselected,
                              fit: BoxFit.contain,
                              scale: 1.8,
                            ),
                            const SizedBox(height: 2),
                          ],
                        ),
                        activeIcon: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppAssets.berandaSelected,
                              fit: BoxFit.contain,
                              scale: 1.8,
                            ),
                            const SizedBox(height: 2),
                          ],
                        ),
                        label: 'Beranda',
                      ),
                      BottomNavigationBarItem(
                        icon: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppAssets.pesananUnselected,
                              fit: BoxFit.contain,
                              scale: 1.8,
                            ),
                            const SizedBox(height: 2),
                          ],
                        ),
                        activeIcon: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppAssets.pesananSelected,
                              fit: BoxFit.contain,
                              scale: 1.8,
                            ),
                            const SizedBox(height: 2),
                          ],
                        ),
                        label: 'Pesanan',
                      ),
                      BottomNavigationBarItem(
                        icon: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppAssets.scanIcon,
                              fit: BoxFit.contain,
                              scale: 1.8,
                            ),
                            const SizedBox(height: 2),
                          ],
                        ),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                        icon: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppAssets.artikelUnselected,
                              fit: BoxFit.contain,
                              scale: 1.8,
                            ),
                            const SizedBox(height: 2),
                          ],
                        ),
                        activeIcon: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppAssets.artikelSelected,
                              fit: BoxFit.contain,
                              scale: 1.8,
                            ),
                            const SizedBox(height: 2),
                          ],
                        ),
                        label: 'Artikel',
                      ),
                      BottomNavigationBarItem(
                        icon: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppAssets.akunUnselected,
                              fit: BoxFit.contain,
                              scale: 1.8,
                            ),
                            const SizedBox(height: 2),
                          ],
                        ),
                        activeIcon: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppAssets.akunSelected,
                              fit: BoxFit.contain,
                              scale: 1.8,
                            ),
                            const SizedBox(height: 2),
                          ],
                        ),
                        label: 'Akun',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
