import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';

class ItemPesanan extends StatefulWidget {
  final String name;
  final String image;
  final int price;
  final int initialQuantity;
  final int id; // Added id property
  final Function(int, int, int) onQuantityChanged; // Callback function to send quantity and id

  const ItemPesanan({
    required this.name,
    required this.price,
    required this.image,
    required this.initialQuantity,
    required this.id, // Include the id in the constructor
    required this.onQuantityChanged, // Pass the callback function
    Key? key,
  }) : super(key: key);

  @override
  _ItemPesananState createState() => _ItemPesananState();
}

class _ItemPesananState extends State<ItemPesanan> {
  int quantity = 1;
  Timer? _debounce; // Timer for debounce

  @override
  void initState() {
    super.initState();
    quantity = widget.initialQuantity; // Set initial quantity from parent
  }

  // Increment with debounce
  void _incrementQuantity() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        quantity++;
      });
      widget.onQuantityChanged(widget.id, quantity, widget.price); // Notify the parent with the updated quantity and id
    });
  }

  // Decrement with debounce
  void _decrementQuantity() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        if (quantity > 1) {
          quantity--;
        }
      });
      widget.onQuantityChanged(widget.id, quantity, widget.price); // Notify the parent with the updated quantity and id
    });
  }

  @override
  void dispose() {
    _debounce?.cancel(); // Cancel the timer when widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              widget.image,
              width: 54,
              height: 54,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: TypographyStyles.semiBold(14, ColorStyles.black),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  currencyFormatter.format(widget.price),
                  style: TypographyStyles.regular(12, ColorStyles.grey),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          IconButton(
            icon: Image.asset(
              AppAssets.iconMinus,
              width: 24,
              height: 24,
            ),
            onPressed: _decrementQuantity,
          ),
          const SizedBox(width: 10),
          Text(
            quantity.toString(),
            style: TypographyStyles.medium(14, ColorStyles.black),
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: Image.asset(
              AppAssets.iconPlus,
              width: 24,
              height: 24,
            ),
            onPressed: _incrementQuantity,
          ),
        ],
      ),
    );
  }
}
