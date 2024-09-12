import 'package:flutter/material.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/widget/button_custom.dart';

class TambahAlamatPage extends StatefulWidget {
  const TambahAlamatPage({super.key});

  @override
  State<TambahAlamatPage> createState() => _TambahAlamatPageState();
}

class _TambahAlamatPageState extends State<TambahAlamatPage> {
  final TextEditingController _labelAlamatController = TextEditingController();
  final TextEditingController _isiAlamatController = TextEditingController();
  final TextEditingController _namaPenerimaController = TextEditingController();
  final TextEditingController _catatanController = TextEditingController();
  final TextEditingController _noPonselController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Tambah Alamat",
          style: TypographyStyles.bold(24, ColorStyles.black),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorStyles.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ListView(
              children: [
                const SizedBox(
                  height: 24,
                ),
                inputField("Label Alamat", _labelAlamatController),
                const SizedBox(
                  height: 16,
                ),
                inputField("Isi Alamat", _isiAlamatController),
                const SizedBox(
                  height: 16,
                ),
                inputField("Nama Penerima", _namaPenerimaController),
                const SizedBox(
                  height: 16,
                ),
                inputField("Catatan", _catatanController),
                const SizedBox(
                  height: 16,
                ),
                inputField("No Ponsel", _noPonselController),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.transparent,
              child: ButtonCustom(
                label: "Simpan Alamat",
                onTap: () {},
                isExpand: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget inputField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TypographyStyles.bold(16, ColorStyles.black),
        ),
        const SizedBox(
          height: 8,
        ),
        TextField(
          style: TypographyStyles.regular(14, ColorStyles.black),
          controller: controller,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            hintText: 'Masukkan $label...',
          ),
        ),
      ],
    );
  }
}
