import 'package:flutter/material.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/pages/artikel/artikel_page.dart';
import 'package:santapan_fe/pages/beranda/beranda_page.dart';
import 'package:santapan_fe/pages/pesanan/pesanan_page.dart';
import 'package:santapan_fe/pages/akun/akun_page.dart';
import 'package:santapan_fe/pages/scan/scan_page.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  void _onPageChanged(int pageIndex) {
    // Map PageView index to BottomNavigationBar index
    int navbarIndex = pageIndex < 2 ? pageIndex : pageIndex + 1;
    setState(() {
      _currentIndex = navbarIndex;
    });
  }

  void _onItemTapped(int index) {
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ScanPage()),
      );
    } else {
      // Map BottomNavigationBar index to PageView index
      int pageIndex = index > 2 ? index - 1 : index;
      setState(() {
        _currentIndex = index;
      });
      _pageController.jumpToPage(pageIndex);
    }
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
              children: const <Widget>[
                BerandaPage(),
                PesananPage(),
                ArtikelPage(),
                AkunPage(),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 95,
                margin: const EdgeInsets.symmetric(horizontal: 12),
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
                        icon: Image.asset(
                          AppAssets.berandaUnselected,
                          fit: BoxFit.contain,
                          scale: 1.8,
                        ),
                        activeIcon: Image.asset(
                          AppAssets.berandaSelected,
                          fit: BoxFit.contain,
                          scale: 1.8,
                        ),
                        label: 'Beranda',
                      ),
                      BottomNavigationBarItem(
                        icon: Image.asset(
                          AppAssets.pesananUnselected,
                          fit: BoxFit.contain,
                          scale: 1.8,
                        ),
                        activeIcon: Image.asset(
                          AppAssets.pesananSelected,
                          fit: BoxFit.contain,
                          scale: 1.8,
                        ),
                        label: 'Pesanan',
                      ),
                      BottomNavigationBarItem(
                        icon: Image.asset(
                          AppAssets.scanIcon,
                          fit: BoxFit.contain,
                          scale: 1.8,
                        ),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                        icon: Image.asset(
                          AppAssets.artikelUnselected,
                          fit: BoxFit.contain,
                          scale: 1.8,
                        ),
                        activeIcon: Image.asset(
                          AppAssets.artikelSelected,
                          fit: BoxFit.contain,
                          scale: 1.8,
                        ),
                        label: 'Artikel',
                      ),
                      BottomNavigationBarItem(
                        icon: Image.asset(
                          AppAssets.akunUnselected,
                          fit: BoxFit.contain,
                          scale: 1.8,
                        ),
                        activeIcon: Image.asset(
                          AppAssets.akunSelected,
                          fit: BoxFit.contain,
                          scale: 1.8,
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
