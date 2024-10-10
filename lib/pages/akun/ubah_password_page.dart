import 'package:flutter/material.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/widget/button_custom.dart';

class UbahPasswordPage extends StatefulWidget {
  const UbahPasswordPage({super.key});

  @override
  State<UbahPasswordPage> createState() => _UbahPasswordPageState();
}

class _UbahPasswordPageState extends State<UbahPasswordPage> {
  final controllerPassword = TextEditingController();
  final controllerConfirmPassword = TextEditingController();
  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Text(
              "Ubah Password",
              style: TypographyStyles.bold(24, ColorStyles.black),
            ),
            const SizedBox(height: 12),
            Text(
              "Ketik kata sandi baru kamu dan konfirmasi",
              style: TypographyStyles.regular(16, ColorStyles.black),
            ),
            const SizedBox(height: 24),
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
              child: TextFormField(
                cursorColor: ColorStyles.black,
                controller: controllerPassword,
                obscureText: isPasswordHidden,
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TypographyStyles.regular(16, ColorStyles.grey),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: const EdgeInsets.all(16),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isPasswordHidden = !isPasswordHidden;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Icon(
                        isPasswordHidden
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: ColorStyles.grey,
                        size: 24,
                      ),
                    ),
                  ),
                ),
                style: TypographyStyles.regular(16, ColorStyles.black),
              ),
            ),
            const SizedBox(
              height: 16,
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
              child: TextFormField(
                cursorColor: ColorStyles.black,
                controller: controllerConfirmPassword,
                obscureText: isConfirmPasswordHidden,
                decoration: InputDecoration(
                  hintText: 'Konfirmasi Password',
                  hintStyle: TypographyStyles.regular(16, ColorStyles.grey),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: const EdgeInsets.all(16),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isConfirmPasswordHidden = !isConfirmPasswordHidden;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Icon(
                        isConfirmPasswordHidden
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: ColorStyles.grey,
                        size: 24,
                      ),
                    ),
                  ),
                ),
                style: TypographyStyles.regular(16, ColorStyles.black),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            ButtonCustom(
              label: "Reset password",
              onTap: () {},
              isExpand: true,
            )
          ],
        ),
      ),
    );
  }
}
