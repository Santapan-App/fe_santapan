import 'package:flutter/material.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/data/models/address_model.dart';
import 'package:santapan_fe/data/urls.dart';
import 'package:santapan_fe/models/response_model.dart';
import 'package:santapan_fe/pages/alamat/tambah_alamat_page.dart';
import 'package:santapan_fe/service/network.dart';
import 'package:santapan_fe/widget/button_custom.dart';

class AlamatPage extends StatefulWidget {
  final bool isFromProfile;
  final AddressData? selectedAddress;  // New parameter

  const AlamatPage({super.key, this.isFromProfile = false, this.selectedAddress});

  @override
  State<AlamatPage> createState() => _AlamatPageState();
}

class _AlamatPageState extends State<AlamatPage> {
  AddressModel? _addressModel;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchAddresses();
    });
  }

  Future<void> fetchAddresses() async {
    setState(() {
      isLoading = true;
    });

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.addressUrl);

    if (response.isSuccess) {
      setState(() {
        _addressModel = AddressModel.fromJson(response.body!);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to load addresses!"),
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          widget.isFromProfile ? "Pilih Alamat" : "Alamat",
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
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : _addressModel?.data?.isEmpty ?? true
                    ? const Center(child: Text("No addresses available"))
                    : ListView.builder(
                        itemCount: _addressModel!.data!.length,
                        itemBuilder: (context, index) {
                          final address = _addressModel!.data![index];
                          return Column(
                            children: [
                              const SizedBox(height: 24),
                              cardAlamat(address, index),
                            ],
                          );
                        },
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
                label: "Tambah Alamat",
                onTap: () async {
                  final bool? isCreated = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TambahAlamatPage()),
                  );

                  if (isCreated != null && isCreated) {
                    fetchAddresses();
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

  Widget cardAlamat(AddressData address, int index) {
    final isSelected = widget.selectedAddress?.id == address.id;  // Check if the address is selected

    return GestureDetector(
      onTap: () {
        if (!widget.isFromProfile) {
          Navigator.pop(context, address);  // Return the selected address
        }
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: isSelected
              ? Border.all(color: ColorStyles.primary, width: 2)
              : null,
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.label ?? "No Label",
                    style: TypographyStyles.bold(16, Colors.black),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    address.address ?? "No Address",
                    style: TypographyStyles.regular(14, ColorStyles.grey),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        address.name ?? "No Name",
                        style: TypographyStyles.semiBold(12, ColorStyles.black),
                        overflow: TextOverflow.clip,
                      ),
                      const SizedBox(width: 16),
                      Text(
                        address.phone ?? "No Phone",
                        style: TypographyStyles.medium(12, ColorStyles.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                final bool? isCreated = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TambahAlamatPage(
                      addressId: address.id ?? 0,
                      initialData: {
                        "label": address.label ?? "",
                        "address": address.address ?? "",
                        "name": address.name ?? "",
                        "phone": address.phone ?? "",
                        "notes": address.notes ?? "",
                      },
                    ),
                  ),
                );

                if (isCreated != null && isCreated) {
                  fetchAddresses();
                }
              },
              child: Image.asset(
                AppAssets.editIcon,
                width: 24,
                height: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
