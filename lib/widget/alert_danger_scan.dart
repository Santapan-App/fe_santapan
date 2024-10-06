import 'package:flutter/material.dart';
import 'package:santapan_fe/core/typography_styles.dart';

class AlertDangerScan extends StatelessWidget {
  const AlertDangerScan({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFCB3A31),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.cancel_rounded,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "Lebih baik hindari makanan ini dulu, ya ☹",
                style: TypographyStyles.bold(14, Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
