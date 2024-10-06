import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/data/urls.dart';
import 'package:santapan_fe/pages/auth/forgot_password_page.dart';
import 'package:santapan_fe/pages/auth/signup_page.dart';
import 'package:santapan_fe/pages/personalisasi/riwayat_penyakit_page.dart';
import 'package:santapan_fe/service/network.dart';
import 'package:santapan_fe/widget/button_custom.dart';
import 'package:santapan_fe/data/utils/auth_utils.dart';
import 'package:santapan_fe/models/login_model.dart';
import 'package:santapan_fe/models/response_model.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  bool isPasswordHidden = true;

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPassword.dispose();
    super.dispose();
  }

  Future<void> login() async {
    String email = controllerEmail.text;
    String password = controllerPassword.text;

    String url = Urls.loginURl;

    Map<String, dynamic> body = {
      'email': email,
      'password': password,
    };

    NetworkResponse response = await NetworkCaller().postRequest(url, body);

    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.isSuccess && response.body != null) {
      LoginModel user = LoginModel.fromJson(response.body!);
      await AuthUtility.setUserInfo(user);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login berhasil!')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const RiwayatPenyakitPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login gagal, coba lagi.')),
      );
    }
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
                const SizedBox(height: 37),
                Text(
                  "Masuk Akun",
                  style: TypographyStyles.bold(24, ColorStyles.black),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    style: TypographyStyles.regular(16, ColorStyles.grey),
                    children: const [
                      TextSpan(
                          text: "Masuk ke akun ",
                          style: TextStyle(color: ColorStyles.grey)),
                      TextSpan(
                          text: "#SobatSantapan",
                          style: TextStyle(color: ColorStyles.primary)),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Email TextField
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2), blurRadius: 4),
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
                const SizedBox(height: 16),
                // Password TextField
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2), blurRadius: 4),
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
                const SizedBox(height: 16),
                // Forgot Password Link
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgotPasswordPage()),
                      );
                    },
                    child: Text(
                      "Lupa password?",
                      style: TypographyStyles.regular(14, ColorStyles.primary),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                // Login Button
                ButtonCustom(
                  label: "Masuk sekarang",
                  onTap: () {
                    login(); // Memanggil fungsi login
                  },
                  isExpand: true,
                ),
                const SizedBox(height: 32),
                // Sign Up Link
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: TypographyStyles.medium(16, ColorStyles.grey),
                      children: [
                        const TextSpan(
                            text: "Belum punya akun?  ",
                            style: TextStyle(color: ColorStyles.grey)),
                        TextSpan(
                          text: "Daftar",
                          style: const TextStyle(color: ColorStyles.primary),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignupPage()),
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
