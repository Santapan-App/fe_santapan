import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/data/models/bundling_detail_model.dart';
import 'package:santapan_fe/data/models/bundling_menu_monthly_model.dart';
import 'package:santapan_fe/data/urls.dart';
import 'package:santapan_fe/models/response_model.dart';
import 'package:santapan_fe/service/network.dart';
import 'package:santapan_fe/widget/button_custom.dart';

class LanggananBulananPage extends StatefulWidget {
  final int id; // Change id to int

  const LanggananBulananPage({super.key, required this.id});

  @override
  State<LanggananBulananPage> createState() => _LanggananBulananPageState();
}

class _LanggananBulananPageState extends State<LanggananBulananPage> with TickerProviderStateMixin {
  late TabController _tabController;
  bool isLoading = false;
  WeeklyMenuModel _menuCategoryModel = WeeklyMenuModel();
  BundlingDetailModel _bundlingDetailModel = BundlingDetailModel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getBundlingMenus();
      getDetailBundling();
    });
    _tabController = TabController(length: 0, vsync: this);
  }

  Future<void> getBundlingMenus() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    // Correctly use the `id` parameter from the widget
    final NetworkResponse response = await NetworkCaller().getRequest('${Urls.bundlingUrl}/2/menu/grouped'); // Use widget.id as int
    if (response.isSuccess) {
      _menuCategoryModel = WeeklyMenuModel.fromJson(response.body!);
      setState(() {
        _tabController.dispose();
        _tabController = TabController(length: _menuCategoryModel.data?.length ?? 0, vsync: this);
      });
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to load data!"),
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

  Future<void> getDetailBundling() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    final NetworkResponse response = await NetworkCaller().getRequest(
        '${Urls.bundlingUrl}/${widget.id}'); // Use widget.id as int

    if (response.isSuccess) {
      _bundlingDetailModel = BundlingDetailModel.fromJson(response.body!);

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to load data!"),
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
  
    
  Future<void> addToCart() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    final NetworkResponse response = await NetworkCaller().postRequest('${Urls.cartUrl}', {
      "bundling_id": widget.id,
      "quantity": 1,
      "image_url": _bundlingDetailModel.data?.imageUrl ?? '',
      "price": _bundlingDetailModel.data?.price ?? 0,
      "menu_id": null,
      "name": _bundlingDetailModel.data?.bundlingName ?? '',
    });
    

    if (response.statusCode == 201) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Added to cart successfully!"),
            backgroundColor: ColorStyles.success,
          ),

        );
      }
      // Notify the previous screen to refetch the cart
      Navigator.pop(context, true); // Return true to signal success
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.body?['message'] ?? "Failed to add to cart!"),
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

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int quantity = 1;

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
    final currencyFormmatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
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
              currencyFormmatter.format(_bundlingDetailModel.data?.price ?? 0),
              style: TypographyStyles.bold(16, ColorStyles.black),
            ),
            const SizedBox(height: 14),
            ButtonCustom(
              label: "Langganan Sekarang",
              onTap: () {
                addToCart();
              },
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
      isScrollable: true,
      indicatorColor: ColorStyles.primary,
      labelColor: ColorStyles.primary,
      unselectedLabelColor: Colors.grey,
      labelStyle: TypographyStyles.semiBold(14, ColorStyles.primary),
      unselectedLabelStyle: TypographyStyles.medium(14, Colors.grey),
      tabs: _menuCategoryModel.data?.map((e) => Tab(text: e.week)).toList() ?? [],
    );
  }

  // TabBarView
  Widget _tabBarView() {
    return TabBarView(
      controller: _tabController,
      children:  _menuCategoryModel.data?.asMap().entries.map((entry) {
      int index = entry.key; // Index of the current item
      var e = entry.value;  // Data for the current item
      return _menuListView(e.week ?? '', index); // Pass the index or use e if needed
    }).toList() ?? [],
    );
  }

  Widget _menuListView(String week, int weekIndex) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _menuCategoryModel.data?[weekIndex].days?.length ?? 0,
      itemBuilder: (context, index) {
        return _foodCard(context, week, _menuCategoryModel.data?[weekIndex].days?[index].day ?? '', _menuCategoryModel.data?[weekIndex].days?[index].menu ?? []);
      },
    );
  }

  Card _foodCard(BuildContext context,
  String week,
  String day,
  List<MenuData> data,
) {
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
              '$week - $day',
              style: TypographyStyles.bold(16, Colors.black),
            ),
            ...data.map((e) => _menuSection(e.menu?.title ?? '', e.menu?.imageUrl ?? '', e.menu?.description ?? '')).toList()
          ],
        ),
      ),
    );
  }

  Widget _menuSection(String title, String src, String description) {
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
                src,
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
                  title,
                  style: TypographyStyles.bold(16, Colors.black),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
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
