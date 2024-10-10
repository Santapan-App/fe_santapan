import 'dart:async';
import 'package:flutter/material.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/widget/button_custom.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final List<TextEditingController> _otpControllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  int _seconds = 60;
  Timer? _timer;
  bool _isCountdownCompleted = false;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _startCountdown() {
    setState(() {
      _seconds = 60; // Reset countdown
      _isCountdownCompleted = false;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          _isCountdownCompleted = true;
          timer.cancel();
        }
      });
    });
  }

  void _nextField(String value, int currentIndex) {
    if (value.length == 1 && currentIndex < 5) {
      FocusScope.of(context).requestFocus(_focusNodes[currentIndex + 1]);
    }
    if (value.isEmpty && currentIndex > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[currentIndex - 1]);
    }
  }

  Widget _buildOtpBox(int index) {
    return Container(
      width: 48,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: _otpControllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        maxLength: 1,
        decoration: const InputDecoration(
          border: InputBorder.none,
          counterText: '',
        ),
        onChanged: (value) {
          _nextField(value, index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorStyles.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Text(
              "Verification",
              style: TypographyStyles.bold(24, ColorStyles.black),
            ),
            const SizedBox(height: 8),
            Text(
              "Kode verifikasi telah dikirim ke (Email)",
              style: TypographyStyles.regular(16, ColorStyles.black),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) {
                return _buildOtpBox(index);
              }),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: _isCountdownCompleted
                  ? GestureDetector(
                      onTap: _startCountdown,
                      child: RichText(
                        text: TextSpan(
                          text: "Kirim kode lain? ",
                          style:
                              TypographyStyles.semiBold(12, ColorStyles.black),
                          children: [
                            TextSpan(
                              text: " Kirim ulang sekarang",
                              style: TypographyStyles.semiBold(
                                  12, ColorStyles.primary),
                            ),
                          ],
                        ),
                      ),
                    )
                  : RichText(
                      text: TextSpan(
                        text: "Tunggu ",
                        style: TypographyStyles.semiBold(12, ColorStyles.black),
                        children: [
                          TextSpan(
                            text: '$_seconds',
                            style: TypographyStyles.semiBold(
                                12, ColorStyles.primary),
                          ),
                          TextSpan(
                            text: " detik sebelum meminta kode lainnya",
                            style: TypographyStyles.semiBold(
                                12, ColorStyles.black),
                          ),
                        ],
                      ),
                    ),
            ),
            const SizedBox(height: 32),
            ButtonCustom(
              isExpand: true,
              label: "Daftar sekarang",
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
