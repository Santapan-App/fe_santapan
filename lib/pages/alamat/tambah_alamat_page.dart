import 'package:flutter/material.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/data/urls.dart';
import 'package:santapan_fe/models/response_model.dart';
import 'package:santapan_fe/service/network.dart';
import 'package:santapan_fe/widget/button_custom.dart';

class TambahAlamatPage extends StatefulWidget {
  final int? addressId; // `null` if creating a new address
  final Map<String, String>? initialData; // Pre-filled data for updating

  const TambahAlamatPage({
    super.key,
    this.addressId,
    this.initialData,
  });

  @override
  State<TambahAlamatPage> createState() => _TambahAlamatPageState();
}

class _TambahAlamatPageState extends State<TambahAlamatPage> {
  late final TextEditingController _labelAlamatController;
  late final TextEditingController _isiAlamatController;
  late final TextEditingController _namaPenerimaController;
  late final TextEditingController _catatanController;
  late final TextEditingController _noPonselController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with initial data for updates
    _labelAlamatController =
        TextEditingController(text: widget.initialData?['label'] ?? '');
    _isiAlamatController =
        TextEditingController(text: widget.initialData?['address'] ?? '');
    _namaPenerimaController =
        TextEditingController(text: widget.initialData?['name'] ?? '');
    _catatanController =
        TextEditingController(text: widget.initialData?['notes'] ?? '');
    _noPonselController =
        TextEditingController(text: widget.initialData?['phone'] ?? '');
  }

  Future<void> saveAddress() async {
    setState(() {
      _isLoading = true;
    });

    final endpoint = Urls.addressUrl;

    final method = widget.addressId == null
        ? NetworkCaller().postRequest // POST for create
        : NetworkCaller().putRequest; // PUT for update

    final response = await method(
      endpoint,
      {
        "label": _labelAlamatController.text,
        "address": _isiAlamatController.text,
        "name": _namaPenerimaController.text,
        "phone": _noPonselController.text,
        "notes": _catatanController.text,
      },
    );

    if (response.isSuccess) {
      Navigator.pop(context, true); // Indicate success
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.addressId == null
              ? "Address created successfully!"
              : "Address updated successfully!"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to save address!"),
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isUpdate = widget.addressId != null;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          isUpdate ? "Edit Alamat" : "Tambah Alamat",
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
                label: _isLoading
                    ? "Saving..."
                    : (isUpdate ? "Update Alamat" : "Simpan Alamat"),
                onTap: () {
                  if (!_isLoading) {
                    saveAddress();
                  }
                },
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
