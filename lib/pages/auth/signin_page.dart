import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/pages/auth/forgot_password_page.dart';
import 'package:santapan_fe/pages/auth/signup_page.dart';
import 'package:santapan_fe/pages/personalisasi/riwayat_penyakit_page.dart';
import 'package:santapan_fe/widget/button_custom.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final controllerEmail = TextEditingController();
  bool isPasswordHidden = true;
  final controllerPassword = TextEditingController();

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      backgroundColor: ColorStyles.bgScreen,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 74),
                  child: Center(
                    child: Image.asset(
                      AppAssets.logoAuth,
                      width: 200,
                      height: 63,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 37,
                ),
                Text(
                  "Masuk Akun",
                  style: TypographyStyles.bold(
                    24,
                    ColorStyles.black,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                RichText(
                  text: TextSpan(
                    style: TypographyStyles.regular(
                        16, ColorStyles.grey), // Style default
                    children: const [
                      TextSpan(
                          text: "Masuk ke akun ",
                          style: TextStyle(color: ColorStyles.grey)),
                      TextSpan(
                        text: "#SobatSantapan",
                        style: TextStyle(
                          color: ColorStyles.primary,
                        ),
                      ),
                    ],
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
                      contentPadding: const EdgeInsets.all(16),
                      isDense: true,
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
                  child: TextField(
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
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPasswordPage()));
                    },
                    child: Text(
                      "Lupa password?",
                      style: TypographyStyles.regular(
                        14,
                        ColorStyles.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                ButtonCustom(
                    label: "Masuk sekarang",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const RiwayatPenyakitPage()));
                    },
                    isExpand: true),
                const SizedBox(
                  height: 32,
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: TypographyStyles.medium(
                          16, ColorStyles.grey), // Style default
                      children: [
                        const TextSpan(
                            text: "Belum punya akun?  ",
                            style: TextStyle(color: ColorStyles.grey)),
                        TextSpan(
                          text: "Daftar",
                          style: const TextStyle(
                            color: ColorStyles.primary,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupPage()),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
