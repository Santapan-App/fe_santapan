import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemCatalog extends StatelessWidget {
  final String name;
  final String imageUrl;
  final double price;
  final double rating;
  final VoidCallback onPress; // Function to handle press events

  const ItemCatalog({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.onPress, // Add required callback
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0);

    return GestureDetector(
      onTap: onPress, // Attach onPress callback to the GestureDetector
      child: Container(
        width: 156,
        height: 250,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0XFFE1E1E1)),
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        currencyFormatter.format(price),
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      const Icon(Icons.star, color: Colors.amber),
                      Text(
                        rating.toString(),
                        style: const TextStyle(fontSize: 12, color: Colors.amber),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
