import 'package:flutter/material.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/data/models/courier_model.dart';
import 'package:santapan_fe/data/urls.dart';
import 'package:santapan_fe/models/response_model.dart';
import 'package:santapan_fe/service/network.dart';
import 'package:santapan_fe/widget/button_custom.dart';

class MethodPaymentPage extends StatefulWidget {
  const MethodPaymentPage({super.key});

  @override
  State<MethodPaymentPage> createState() => _MethodPaymentPageState();
}

class _MethodPaymentPageState extends State<MethodPaymentPage> {
  int _selectedMethod = 0;
  bool isLoading = false;
  CourierResponse? courierResponse;

  Future<void> getCourier() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    final NetworkResponse response = await NetworkCaller().getRequest(Urls.courierUrl);

    if (response.isSuccess) {
      setState(() {
        courierResponse = CourierResponse.fromJson(response.body!);
      });
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to load data!"),
          ),
        );
      }
    }
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCourier();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorStyles.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pilih metode pengiriman",
                          style: TypographyStyles.bold(16, ColorStyles.black),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        courierResponse == null
                            ? const Center(
                                child: Text("No couriers available"),
                              )
                            : Column(
                                children: List.generate(courierResponse!.couriers.length, (index) {
                                  return Container(
                                    width: double.infinity,
                                    height: 70,
                                    margin: const EdgeInsets.only(bottom: 12),
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
                                            Image.network(
                                              courierResponse!.couriers[index].logo,
                                              width: 32,
                                              height: 32,
                                            ),
                                            const SizedBox(width: 12),
                                            Text(
                                              courierResponse!.couriers[index].name,
                                              style: TypographyStyles.bold(14, Colors.black),
                                            ),
                                          ],
                                        ),
                                        Radio<int>(
                                          value: index,
                                          groupValue: _selectedMethod,
                                          onChanged: (int? value) {
                                            setState(() {
                                              _selectedMethod = value!;
                                            });
                                            
                                          },
                                          activeColor: ColorStyles.primary,
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: ButtonCustom(
                      label: "Ganti Kurir",
                      onTap: () {
                        // Aksi ketika tombol diklik
                      },
                      isExpand: true,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
