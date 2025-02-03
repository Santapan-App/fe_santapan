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
  final Function(int, int, int)? onQuantityChanged; // Nullable callback function to send quantity and id

  const ItemPesanan({
    required this.name,
    required this.price,
    required this.image,
    required this.initialQuantity,
    required this.id, // Include the id in the constructor
    this.onQuantityChanged, // Pass the nullable callback function
    Key? key,
  }) : super(key: key);

  @override
  _ItemPesananState createState() => _ItemPesananState();
}

class _ItemPesananState extends State<ItemPesanan> {
  int? quantity; // Changed to nullable int
  Timer? _debounce; // Timer for debounce

  @override
  void initState() {
    super.initState();
    quantity = widget.initialQuantity != null ? widget.initialQuantity : null; // Initialize quantity, checking if it's not null
  }

  // Increment with debounce
  void _incrementQuantity() {
    if (quantity == null) return; // If quantity is null, do not proceed
    
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        quantity = (quantity ?? 0) + 1; // Safe increment, ensuring quantity is not null
      });
      if (widget.onQuantityChanged != null) {
        widget.onQuantityChanged!(widget.id, quantity!, widget.price); // Call the callback only if it's not null
      }
    });
  }

  // Decrement with debounce
  void _decrementQuantity() {
    if (quantity == null) return; // If quantity is null, do not proceed
    
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        if (quantity != null && quantity! > 1) {
          quantity = quantity! - 1; // Safe decrement, ensuring quantity is not null
        }
      });
      if (widget.onQuantityChanged != null) {
        widget.onQuantityChanged!(widget.id, quantity!, widget.price); // Call the callback only if it's not null
      }
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
                  "${currencyFormatter.format(widget.price)} x ${quantity ?? 'N/A'}",
                  style: TypographyStyles.regular(12, ColorStyles.grey),
                ),
              ],
            ),
          ),
          // Show quantity control buttons only if onQuantityChanged is not null
          if (widget.onQuantityChanged != null) ...[
            IconButton(
              icon: Image.asset(
                AppAssets.iconMinus,
                width: 24,
                height: 24,
              ),
              onPressed: quantity == null ? null : _decrementQuantity, // Disable if quantity is null
            ),
            const SizedBox(width: 10),
            // Display quantity only if it's not null
            Text(
              quantity?.toString() ?? 'N/A',
              style: TypographyStyles.medium(14, ColorStyles.black),
            ),
            const SizedBox(width: 10),
            IconButton(
              icon: Image.asset(
                AppAssets.iconPlus,
                width: 24,
                height: 24,
              ),
              onPressed: quantity == null ? null : _incrementQuantity, // Disable if quantity is null
            ),
          ],
        ],
      ),
    );
  }
}
