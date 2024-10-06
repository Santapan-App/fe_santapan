import 'package:flutter/material.dart';

class ButtonPesanan extends StatelessWidget {
  final String label;
  final Color borderColor;
  final TextStyle textStyle;
  final double width;
  final VoidCallback onPressed;

  const ButtonPesanan({
    super.key,
    required this.label,
    required this.borderColor,
    required this.textStyle,
    required this.width,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      width: width,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          side: BorderSide(color: borderColor),
          padding: const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          label,
          style: textStyle,
        ),
      ),
    );
  }
}
