import 'package:flutter/material.dart';
import 'package:santapan_fe/core/typography_styles.dart';

class AlertSuccessScan extends StatelessWidget {
  const AlertSuccessScan({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF31B057),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.check_box_rounded,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "Hore! Makanan ini bisa kamu konsumsi loh 🤩",
                style: TypographyStyles.bold(14, Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
