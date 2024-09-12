import 'package:flutter/material.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/widget/button_custom.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final controllerEmail = TextEditingController();

  @override
  void dispose() {
    controllerEmail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorStyles.bgScreen,
        appBar: AppBar(
          backgroundColor: ColorStyles.bgScreen,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 24,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: null,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "Lupa Password?",
                  style: TypographyStyles.bold(
                    24,
                    ColorStyles.black,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Gak perlu khawatir, masukkan alamat email kamu dan kami akan mengirimkan kode verifikasi untuk mereset kata sandi.",
                  style: TypographyStyles.regular(
                    14,
                    ColorStyles.black.withOpacity(0.8),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: TextField(
                    cursorColor: ColorStyles.black,
                    controller: controllerEmail,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: TypographyStyles.regular(16, ColorStyles.grey),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: const EdgeInsets.all(16),
                    ),
                    style: TypographyStyles.regular(16, ColorStyles.black),
                  ),
                ),
                const SizedBox(
                  height: 36,
                ),
                ButtonCustom(
                  label: "Kirim verifikasi",
                  onTap: () {},
                  isExpand: true,
                )
              ],
            ),
          ),
        ));
  }
}
