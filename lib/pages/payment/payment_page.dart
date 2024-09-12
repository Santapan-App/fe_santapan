import 'package:flutter/material.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/pages/payment/method_payment_page.dart';
import 'package:santapan_fe/widget/button_custom.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int quantity = 1; // State variable to keep track of the quantity

  void _incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Pembayaran",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              alamatCard(),
              const SizedBox(
                height: 12,
              ),
              pilihKurir(),
              const SizedBox(
                height: 12,
              ),
              daftarPesanan(),
              const SizedBox(
                height: 12,
              ),
              promoCard(),
              const SizedBox(
                height: 12,
              ),
              detailPesanan(context),
              const SizedBox(
                height: 32,
              ),
              ButtonCustom(
                label: "Pilih Metode Pembayaran",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MethodPaymentPage()));
                },
                isExpand: true,
              ),
              const SizedBox(
                height: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container detailPesanan(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0XFFEDEDED)),
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Detail Pesanan",
            style: TypographyStyles.semiBold(16, ColorStyles.black),
          ),
          const SizedBox(
            height: 10,
          ),
          itemDetailPesanan(context, "Subtotal", "Rp 45.000"),
          const SizedBox(
            height: 10,
          ),
          itemDetailPesanan(context, "Pengiriman", "Rp 100.000"),
          const SizedBox(
            height: 10,
          ),
          itemDetailPesanan(context, "Total", "Rp 100.000"),
        ],
      ),
    );
  }

  Row itemDetailPesanan(BuildContext context, String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TypographyStyles.medium(14, ColorStyles.black),
        ),
        Text(
          value,
          style: TypographyStyles.medium(14, ColorStyles.black),
        ),
      ],
    );
  }

  Container daftarPesanan() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0XFFEDEDED)),
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Daftar Pesanan",
            style: TypographyStyles.semiBold(16, ColorStyles.black),
          ),
          const SizedBox(
            height: 12,
          ),
          itemPesanan(),
          const SizedBox(
            height: 12,
          ),
          itemPesanan(),
        ],
      ),
    );
  }

  Container itemPesanan() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              "https://picsum.photos/200/300",
              width: 54,
              height: 54,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nama makanan",
                  style: TypographyStyles.semiBold(14, ColorStyles.black),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  "Rp 20,000",
                  style: TypographyStyles.regular(12, ColorStyles.grey),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          IconButton(
            icon: Image.asset(
              AppAssets.iconMinus,
              width: 24,
              height: 24,
            ),
            onPressed: _decrementQuantity,
          ),
          const SizedBox(width: 10),
          Text(
            "$quantity",
            style: TypographyStyles.medium(14, ColorStyles.black),
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: Image.asset(
              AppAssets.iconPlus,
              width: 24,
              height: 24,
            ),
            onPressed: _incrementQuantity,
          ),
        ],
      ),
    );
  }

  Container promoCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0XFFEDEDED)),
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            AppAssets.paymentPromo,
            width: 42,
            height: 42,
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(
              "Promo",
              style: TypographyStyles.semiBold(14, ColorStyles.black),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_forward_ios,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Container pilihKurir() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0XFFEDEDED)),
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            AppAssets.paymentKurir,
            width: 42,
            height: 42,
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(
              "Pilih Kurir",
              style: TypographyStyles.semiBold(14, ColorStyles.black),
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_forward_ios,
                size: 24,
              ))
        ],
      ),
    );
  }

  Container alamatCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0XFFEDEDED)),
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                AppAssets.paymentAlamat,
                width: 42,
                height: 42,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Santapan",
                    style: TypographyStyles.semiBold(14, ColorStyles.black),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Santapan, Bandung",
                    style: TypographyStyles.regular(12, ColorStyles.grey),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              children: [
                for (int i = 0; i < 3; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Container(
                      width: 4,
                      height: 4,
                      decoration: const BoxDecoration(
                        color: Color(0xFF1C1C1C),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    AppAssets.paymentDestination,
                    width: 42,
                    height: 42,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pengantaran",
                          style:
                              TypographyStyles.semiBold(14, ColorStyles.black),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Jl Hj Umayah II, Kota Bandung",
                          style: TypographyStyles.regular(12, ColorStyles.grey),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 0,
                top: 10,
                child: Image.asset(
                  AppAssets.editIcon,
                  width: 24,
                  height: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Notes:",
                style: TypographyStyles.semiBold(14, ColorStyles.black),
              ),
              Image.asset(
                AppAssets.editIcon,
                width: 24,
                height: 24,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
