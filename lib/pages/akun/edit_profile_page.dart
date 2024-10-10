import 'package:flutter/material.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/widget/button_custom.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Inisialisasi data pengguna
    _nameController.text = "Full Name 1213u1u39u19";
    _emailController.text = "email@example.com";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profil",
            style: TypographyStyles.bold(20, ColorStyles.black)),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              const SizedBox(height: 24),
              _buildTextField(
                controller: _nameController,
                hintText: "Nama kamu",
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _emailController,
                hintText: "Alamat Email",
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 32),
              ButtonCustom(
                label: "Simpan",
                onTap: () {},
                isExpand: true,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    bool isPassword = false,
  }) {
    return Container(
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
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TypographyStyles.regular(16, ColorStyles.grey),
          border: InputBorder.none, // Menghapus border default
          contentPadding: const EdgeInsets.all(16), // Padding dalam TextField
          isDense: true, // Menyesuaikan kepadatan agar lebih ringkas
        ),
        style: TypographyStyles.regular(16, ColorStyles.black), // Gaya teks
      ),
    );
  }

  void _saveProfile() {
    String name = _nameController.text;
    String email = _emailController.text;
    String phone = _phoneController.text;

    // Logika penyimpanan atau update profil
    print(
        "Profil disimpan dengan data: Nama: $name, Email: $email, Telepon: $phone");

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profil berhasil diperbarui")),
    );

    Navigator.pop(context);
  }
}
