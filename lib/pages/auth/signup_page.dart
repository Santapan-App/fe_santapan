import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/data/urls.dart';
import 'package:santapan_fe/models/response_model.dart';
import 'package:santapan_fe/pages/auth/signin_page.dart';
import 'package:santapan_fe/pages/auth/verification_page.dart';
import 'package:santapan_fe/service/network.dart';
import 'package:santapan_fe/widget/button_custom.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final controllerFullName = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerConfirmPassword = TextEditingController();
  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _signUpInProgress = false;

  Future<void> userSignUp() async {
    _signUpInProgress = true;
    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> requestBody = {
      "full_name": controllerFullName.text.trim(),
      "email": controllerEmail.text.trim(),
      "password": controllerPassword.text,
      "confirm_password": controllerConfirmPassword.text
    };

    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.registerURl, requestBody);

    print('Response Status: ${response.isSuccess}');
    print('Response Message: ${response.body}');

    _signUpInProgress = false;

    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {
      controllerEmail.clear();
      controllerFullName.clear();
      controllerPassword.clear();
      controllerConfirmPassword.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Registration Successful"),
          backgroundColor: Colors.green, // warna hijau untuk sukses
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SigninPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Registration Failed: ${response.body}"),
          backgroundColor: Colors.red, // warna merah untuk gagal
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.bgScreen,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
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
                    "Daftar Akun",
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
                      style: TypographyStyles.regular(16, ColorStyles.grey),
                      children: const [
                        TextSpan(
                          text: "Daftar akun ",
                          style: TextStyle(color: ColorStyles.grey),
                        ),
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
                  // Full Name Field
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
                      controller: controllerFullName,
                      decoration: InputDecoration(
                        hintText: 'Nama kamu',
                        hintStyle:
                            TypographyStyles.regular(16, ColorStyles.grey),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(16),
                        isDense: true,
                      ),
                      style: TypographyStyles.regular(16, ColorStyles.black),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  // Email Field
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
                      controller: controllerEmail,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle:
                            TypographyStyles.regular(16, ColorStyles.grey),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(16),
                        isDense: true,
                      ),
                      style: TypographyStyles.regular(16, ColorStyles.black),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email tidak boleh kosong';
                        }
                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value.trim())) {
                          return 'Email tidak valid';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  // Password Field
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
                        hintStyle:
                            TypographyStyles.regular(16, ColorStyles.grey),
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password tidak boleh kosong';
                        }
                        if (value.length < 8) {
                          return 'Password harus lebih dari 8 karakter';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  // Confirm Password Field
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
                        hintStyle:
                            TypographyStyles.regular(16, ColorStyles.grey),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: const EdgeInsets.all(16),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isConfirmPasswordHidden =
                                  !isConfirmPasswordHidden;
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Konfirmasi password tidak boleh kosong';
                        }
                        if (value != controllerPassword.text) {
                          return 'Password tidak cocok';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  // Signup Button
                  ButtonCustom(
                    isExpand: true,
                    label: _signUpInProgress
                        ? 'Sedang memproses...'
                        : "Daftar sekarang",
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        userSignUp();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: TypographyStyles.regular(14, ColorStyles.grey),
                        children: [
                          const TextSpan(text: "Sudah punya akun? "),
                          TextSpan(
                            text: "Masuk",
                            style:
                                TypographyStyles.bold(14, ColorStyles.primary),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SigninPage()),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
