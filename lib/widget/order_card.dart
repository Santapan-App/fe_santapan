import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/data/models/cart_item_model.dart';
import 'package:santapan_fe/data/urls.dart';
import 'package:santapan_fe/models/response_model.dart';
import 'package:santapan_fe/service/network.dart';

class OrderCard extends StatefulWidget {
  final int orderId;
  final String date;
  final String status;
  final String totalPrice;
  final VoidCallback? onTap;

  const OrderCard({
    super.key,
    required this.orderId,
    required this.date,
    required this.status,
    required this.totalPrice,
    this.onTap,
  });

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool isLoading = false;
  CartResponseModel? cartResponseModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      fetchOrderDetails();
    });
  }

  Future<void> fetchOrderDetails() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    final NetworkResponse response = await NetworkCaller().getRequest(Urls.cartUrl + "/" + widget.orderId.toString());
    if (response.isSuccess) {
      cartResponseModel = CartResponseModel.fromJson(response.body!);
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
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
    final totalPrice = cartResponseModel?.data?.items?.map((item) => item.price ?? 0).reduce((a, b) => a + b) ?? 0;
    final formatTotalPrice = currencyFormatter.format(totalPrice);
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.date,
                  style: TypographyStyles.regular(14, ColorStyles.grey),
                ),
                Text(
                  widget.status,
                  style: TypographyStyles.medium(16, ColorStyles.primary),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Image.asset(
                  AppAssets.imagePesanan,
                  width: 40,
                  height: 40,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    cartResponseModel?.data?.items?.map((item) => item.name ?? '').join(", ") ?? "Loading...",
                    style: TypographyStyles.semiBold(
                      14,
                      ColorStyles.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Harga",
                  style: TypographyStyles.medium(14, ColorStyles.black),
                ),
                Text(
                  formatTotalPrice,
                  style: TypographyStyles.bold(14, ColorStyles.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
