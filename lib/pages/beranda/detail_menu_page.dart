import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/data/models/menu_detail_model.dart';
import 'package:santapan_fe/data/urls.dart';
import 'package:santapan_fe/models/response_model.dart';
import 'package:santapan_fe/pages/beranda/nutrisi_info.dart';
import 'package:santapan_fe/service/network.dart';
import 'package:santapan_fe/widget/button_custom.dart';

class DetailMenuPage extends StatefulWidget {
  final int id; // Change id to int

  const DetailMenuPage({super.key, required this.id});

  @override
  State<DetailMenuPage> createState() => _DetailMenuPageState();
}

class _DetailMenuPageState extends State<DetailMenuPage> {
  bool isLoading = false;
  MenuDetailModel _menuDetailModel = MenuDetailModel();

  int quantity = 1;
  num pricePerItem = 0;
  num get totalPrice => pricePerItem * quantity;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        pricePerItem = _menuDetailModel.data?.price ?? 0;
      });
      getDetailMenu();
    });
  }

  Future<void> getDetailMenu() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    // Correctly use the `id` parameter from the widget
    final NetworkResponse response = await NetworkCaller().getRequest(
        '${Urls.menuUrl}/${widget.id}'); // Use widget.id as int

    if (response.isSuccess) {
      _menuDetailModel = MenuDetailModel.fromJson(response.body!);
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
      "bundling_id": null,
      "quantity": quantity,
      "price": (_menuDetailModel.data?.price ?? 0) * quantity,
      "menu_id": widget.id,
      "name": _menuDetailModel.data?.title ?? '',
      "image_url": _menuDetailModel.data?.imageUrl ?? '',
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
          const SnackBar(
            content: Text("Failed to add to cart!"),
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
    final currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                imageMenu(context, _menuDetailModel.data?.imageUrl ?? ''),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _menuDetailModel.data?.title ?? 'Loading..',
                        style: TypographyStyles.bold(20, ColorStyles.black),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        currencyFormatter.format(_menuDetailModel.data?.price ?? 0),
                        style: TypographyStyles.semiBold(16, ColorStyles.black),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _menuDetailModel.data?.description ?? '',
                        style: TypographyStyles.regular(16, ColorStyles.black),
                      ),
                      const SizedBox(height: 12),
                      if (_menuDetailModel.data?.features?.glutenFree ?? false)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.check_circle,
                            size: 24,
                            color: ColorStyles.success,
                          ),
                          const SizedBox(width: 12),
                          // Check if the menu is suitable for diabetes
                          Flexible(
                            child: Text(
                              "Cocok untuk penderita diabetes.",
                              style: TypographyStyles.regular(
                                  16, ColorStyles.black),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      if (_menuDetailModel.data?.features?.vegetarian ?? false)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.eco,
                            size: 24,
                            color: Colors.green,
                          ),
                          const SizedBox(width: 12),
                          // Check if the menu is suitable for diabetes
                          Flexible(
                            child: Text(
                              "Cocok untuk vegetarian.",
                              style: TypographyStyles.regular(
                                  16, ColorStyles.black),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      notes(),
                      const SizedBox(height: 12),
                      NutrisiInfo(nutrition: _menuDetailModel.data?.nutrition ?? Nutrition()),
                      // const SizedBox(height: 10),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(
                      //       "Ulasan",
                      //       style: TypographyStyles.bold(16, ColorStyles.black),
                      //     ),
                      //     TextButton(
                      //       onPressed: () {},
                      //       child: Text(
                      //         "Lihat Semua",
                      //         style: TypographyStyles.regular(
                      //             12, ColorStyles.primary),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // ulasanUser(),
                      // const SizedBox(height: 8),
                      // ulasanUser(),
                      // const SizedBox(height: 8),
                      // ulasanUser(),
                    ],
                  ),
                ),
                const SizedBox(height: 200),
              ],
            ),
          ),
          bottomButtonPrice(),
        ],
      ),
    );
  }

  Positioned bottomButtonPrice() {
    final currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
    final totalPriceQty = (_menuDetailModel.data?.price ?? 0) * quantity;
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Harga",
                      style: TypographyStyles.semiBold(14, ColorStyles.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      currencyFormatter.format(totalPriceQty),
                      style: TypographyStyles.bold(16, ColorStyles.black),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (quantity > 1) {
                            quantity--;
                          }
                        });
                      },
                      child: Image.asset(
                        AppAssets.iconMinus,
                        width: 24,
                        height: 24,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "$quantity",
                      style: TypographyStyles.bold(16, ColorStyles.black),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          quantity++;
                        });
                      },
                      child: Image.asset(
                        AppAssets.iconPlus,
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 14),
            ButtonCustom(
              label: "Tambah ke Keranjang",
              isLoading: isLoading,
              onTap: () {
                addToCart();
              },
              isExpand: true,
            ),
          ],
        ),
      ),
    );
  }

  SizedBox ulasanUser() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                AppAssets.profileIcon,
                width: 36,
                height: 36,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nama User",
                      style: TypographyStyles.bold(12, ColorStyles.black),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: List.generate(
                        5,
                        (index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse convallis.",
                      style: TypographyStyles.regular(12, ColorStyles.black),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container notes() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Notes: ",
                      style: TypographyStyles.bold(16, ColorStyles.black),
                    ),
                    TextSpan(
                      text: "(Optional)",
                      style: TypographyStyles.regular(16, ColorStyles.black),
                    ),
                  ],
                ),
              ),
              Image.asset(
                AppAssets.editIcon,
                width: 24,
                height: 24,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "Contoh: packing rapi, jangan pakai sambal, di pisah saus nya.",
            style: TypographyStyles.regular(14, const Color(0xFF7A7A7A)),
          ),
        ],
      ),
    );
  }

  Stack imageMenu(BuildContext context, String imageUrl) {
  return Stack(
    children: [
      SizedBox(
        width: double.infinity,
        height: 330,
        child: imageUrl.isNotEmpty
            ? Image.network(
                imageUrl,
                fit: BoxFit.cover,
              )
            : CircularProgressIndicator(),
      ),
      Positioned(
        top: 65,
        left: 16,
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset(
            AppAssets.leftRoundedIcon,
            width: 40,
            height: 40,
          ),
        ),
      ),
    ],
  );
}
}
