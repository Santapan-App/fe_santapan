import 'package:flutter/material.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/data/models/bundling_detail_model.dart';
import 'package:santapan_fe/data/models/bundling_menu_model.dart';
import 'package:santapan_fe/data/urls.dart';
import 'package:santapan_fe/models/response_model.dart';
import 'package:santapan_fe/service/network.dart';
import 'package:santapan_fe/widget/button_custom.dart';

class LanggananMingguanPage extends StatefulWidget {
  final int id; // Change id to int

  const LanggananMingguanPage({Key? key, required this.id}) : super(key: key);

  @override
  State<LanggananMingguanPage> createState() => _LanggananMingguanPageState();
}

class _LanggananMingguanPageState extends State<LanggananMingguanPage> {
  bool isLoading = false;
  MenuCategoryModel _menuCategoryModel = MenuCategoryModel();
  BundlingDetailModel _bundlingDetailModel = BundlingDetailModel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getBundlingMenus();
      getDetailBundling();
    });
  }

  Future<void> getBundlingMenus() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    // Correctly use the `id` parameter from the widget
    final NetworkResponse response = await NetworkCaller().getRequest(
        '${Urls.bundlingUrl}/${widget.id}/menu'); // Use widget.id as int

    if (response.isSuccess) {
      _menuCategoryModel = MenuCategoryModel.fromJson(response.body!);
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
    final bodyCart = {
      "bundling_id": widget.id,
      "quantity": 1,
      "price": _bundlingDetailModel.data?.price ?? 0,
      "menu_id": null,
      "image_url": _bundlingDetailModel.data?.imageUrl ?? '',
      "name": _bundlingDetailModel.data?.bundlingName ?? '',
    };
    final NetworkResponse response = await NetworkCaller().postRequest('${Urls.cartUrl}', {
      "bundling_id": widget.id,
      "quantity": 1,
      "price": _bundlingDetailModel.data?.price ?? 0,
      "menu_id": null,
      "image_url": _bundlingDetailModel.data?.imageUrl ?? '',
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                imageTop(context),
                const SizedBox(height: 16),
                ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _menuCategoryModel.data?.length ?? 0,
                  shrinkWrap: true, // Allow the ListView to take its height
                  physics:
                      const NeverScrollableScrollPhysics(), // Disable scrolling
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        foodCard(
                            context,
                            _menuCategoryModel.data![index].day ?? '',
                            _menuCategoryModel.data![index].menu ?? []),
                        const SizedBox(height: 6),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 200),
              ],
            ),
          ),
          bottomButton()
        ],
      ),
    );
  }

  Positioned bottomButton() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
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
                "Rp ${_bundlingDetailModel.data?.price ?? 0}",
                style: TypographyStyles.bold(16, ColorStyles.black),
              ),
              const SizedBox(height: 14),
              ButtonCustom(
                label: "Langganan sekarang",
                onTap: () {
                  addToCart();
                },
                isLoading: isLoading,
                isExpand: true,
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }

  Stack imageTop(BuildContext context) {
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
              const SizedBox(width: 100),
              Text(
                "Mingguan",
                style: TypographyStyles.bold(20, Colors.black),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Card foodCard(BuildContext context, String day, List<MenuData> data) {
    // List of meal types

    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              day,
              style: TypographyStyles.bold(20, Colors.black),
            ),
            const SizedBox(height: 8),
            // Dynamically generate menuSection widgets for each meal
            ...data.map((meal) => Column(
                  children: [
                    menuSection(
                        meal.menu?.title ?? '', meal.menu?.description ?? '', meal.menu?.imageUrl ?? ''),
                    const SizedBox(height: 8),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  // Widget untuk menu lunch dan dinner
  Widget menuSection(String title, String description, String imageUrl) {
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
                imageUrl,
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
