import 'package:flutter/material.dart';
import 'package:santapan_fe/core/typography_styles.dart';

class AlertWarningScan extends StatelessWidget {
  const AlertWarningScan({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF5A324),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.warning,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "Kamu boleh kok makan ini asal jangan terlalu banyak ya ..🙂",
                style: TypographyStyles.bold(14, Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
