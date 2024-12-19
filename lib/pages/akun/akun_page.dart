import 'package:flutter/material.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/data/utils/auth_utils.dart';
import 'package:santapan_fe/pages/akun/bantuan_page.dart';
import 'package:santapan_fe/pages/akun/edit_profile_page.dart';
import 'package:santapan_fe/pages/akun/ubah_password_page.dart';
import 'package:santapan_fe/pages/alamat/alamat_page.dart';
import 'package:santapan_fe/pages/auth/signin_page.dart';
import 'package:santapan_fe/pages/personalisasi/personalisasi_page.dart';

class AkunPage extends StatefulWidget {
  const AkunPage({super.key});

  @override
  State<AkunPage> createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                Align(
                  child: Text(
                    "Akun",
                    style: TypographyStyles.semiBold(24, ColorStyles.black),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 24),
                InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditProfilePage(),
                        ),
                      );
                    },
                    child: profileMenu()),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
                  child: Column(
                    children: [
                      itemMenu(context, AppAssets.chatIcon, "Santapan Care"),
                      const SizedBox(height: 12),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const UbahPasswordPage()));
                        },
                        child: itemMenu(context, AppAssets.passwordKeyIcon,
                            "Ubah Password"),
                      ),
                      const SizedBox(height: 12),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AlamatPage(
                                        isFromProfile: true,
                                  )));
                        },
                        child: itemMenu(
                            context, AppAssets.alamatIcon, "Alamat Tersimpan"),
                      ),
                      const SizedBox(height: 12),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const BantuanPage()));
                          },
                          child: itemMenu(
                              context, AppAssets.bantuanIcon, "Bantuan")),
                      const SizedBox(height: 12),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SigninPage()));
                          },
                          child: itemMenu(
                              context, AppAssets.logoutIcon, "Logout")),
                      const SizedBox(height: 12),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container itemMenu(BuildContext context, String icon, String label) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0XFFE1E1E1)),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                icon,
                width: 32,
                height: 32,
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: TypographyStyles.regular(14, Colors.black),
              ),
            ],
          ),
          Row(
            children: [
              Image.asset(AppAssets.rightAkun, width: 24, height: 24),
            ],
          ),
        ],
      ),
    );
  }

  Container profileMenu() {
    return Container(
      width: double.infinity,
      height: 86,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.fromLTRB(10, 16, 10, 16),
      child: Row(
        children: [
          Image.asset(
            AppAssets.profileIcon,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AuthUtility.userInfo.email ?? '',
                  style: TypographyStyles.semiBold(16, ColorStyles.black),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  AuthUtility.userInfo.fullName ?? '',
                  style: TypographyStyles.medium(14, ColorStyles.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Image.asset(
            AppAssets.editIcon,
            width: 24,
            height: 24,
          )
        ],
      ),
    );
  }
}
