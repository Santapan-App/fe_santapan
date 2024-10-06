import 'package:flutter/material.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/widget/button_custom.dart';

class LanggananBulananPage extends StatefulWidget {
  const LanggananBulananPage({super.key});

  @override
  State<LanggananBulananPage> createState() => _LanggananBulananPageState();
}

class _LanggananBulananPageState extends State<LanggananBulananPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int quantity = 1;
  final double pricePerItem = 50000;
  double get totalPrice => pricePerItem * quantity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _imageTop(context),
          const SizedBox(height: 16),
          _tabBar(),
          Expanded(
            child: _tabBarView(),
          ),
          _bottomButton(),
        ],
      ),
    );
  }

  Container _bottomButton() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: ColorStyles.grey.withOpacity(0.1),
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total Harga",
              style: TypographyStyles.semiBold(14, ColorStyles.grey),
            ),
            const SizedBox(height: 4),
            Text(
              "Rp ${totalPrice.toString()}",
              style: TypographyStyles.bold(16, ColorStyles.black),
            ),
            const SizedBox(height: 14),
            ButtonCustom(
              label: "Langganan Sekarang",
              onTap: () {},
              isExpand: true,
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }

  Stack _imageTop(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 244,
          child: Image.asset(
            AppAssets.bannerMingguan,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 65,
          left: 16,
          right: 0,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  AppAssets.leftRoundedIcon,
                  width: 40,
                  height: 40,
                ),
              ),
              const SizedBox(width: 120),
              Text(
                "Bulanan",
                style: TypographyStyles.bold(20, Colors.black),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // TabBar
  Widget _tabBar() {
    return TabBar(
      controller: _tabController,
      indicatorColor: ColorStyles.primary,
      labelColor: ColorStyles.primary,
      unselectedLabelColor: Colors.grey,
      labelStyle: TypographyStyles.semiBold(14, ColorStyles.primary),
      unselectedLabelStyle: TypographyStyles.medium(14, Colors.grey),
      tabs: const [
        Tab(text: "Minggu 1"),
        Tab(text: "Minggu 2"),
        Tab(text: "Minggu 3"),
        Tab(text: "Minggu 4"),
      ],
    );
  }

  // TabBarView
  Widget _tabBarView() {
    return TabBarView(
      controller: _tabController,
      children: [
        _menuListView(1),
        _menuListView(2),
        _menuListView(3),
        _menuListView(4),
      ],
    );
  }

  Widget _menuListView(int week) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 7,
      itemBuilder: (context, index) {
        return _foodCard(context, week, index + 1);
      },
    );
  }

  Card _foodCard(BuildContext context, int week, int day) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Minggu $week - Hari $day',
              style: TypographyStyles.bold(16, Colors.black),
            ),
            const SizedBox(height: 8),
            _menuSection("Lunch", week, day),
            const SizedBox(height: 8),
            _menuSection("Dinner", week, day),
          ],
        ),
      ),
    );
  }

  Widget _menuSection(String mealType, int week, int day) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              width: 60,
              height: 60,
              child: Image.network(
                "https://picsum.photos/id/${(week * 7 + day)}/200/200",
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$mealType - Nama Menu',
                  style: TypographyStyles.bold(16, Colors.black),
                ),
                const SizedBox(height: 4),
                Text(
                  'Deskripsi singkat untuk $mealType pada Minggu $week, Hari $day.',
                  style: TypographyStyles.regular(14, Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
