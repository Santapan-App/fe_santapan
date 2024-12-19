import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/data/models/address_model.dart';
import 'package:santapan_fe/data/models/cart_item_model.dart';
import 'package:santapan_fe/data/models/transaction_model.dart';
import 'package:santapan_fe/data/urls.dart';
import 'package:santapan_fe/models/response_model.dart';
import 'package:santapan_fe/pages/alamat/alamat_page.dart';
import 'package:santapan_fe/pages/payment/method_payment_page.dart';
import 'package:santapan_fe/pages/pesanan/detail_status_pesanan_page.dart';
import 'package:santapan_fe/service/network.dart';
import 'package:santapan_fe/widget/button_custom.dart';
import 'package:santapan_fe/widget/item_pesnanan.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  // This map holds the quantity for each item by its ID
  Map<int, int> itemQuantities = {};
  int subtotal = 0;
  AddressData? address;
  int? courierID;

  // Callback function to get updated quantity and id
  void _onQuantityChanged(int id, int updatedQuantity, int price) {
    setState(() {
      itemQuantities[id] = updatedQuantity;
      subtotal = updatedQuantity * price;
    });
  }

  bool isLoadingCart = false;

  CartResponseModel cartResponseModel = CartResponseModel();
  PaymentDetailModel transactionResponseModel = PaymentDetailModel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCart();
    });
  }

  // Get Cart
  Future<void> getCart() async {
    if (mounted) {
      setState(() {
        isLoadingCart = true;
      });
    }

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.cartUrl);
    if (response.isSuccess) {
      cartResponseModel = CartResponseModel.fromJson(response.body!);
    
      if (mounted) {
        setState(() {
          isLoadingCart = false;
          subtotal = cartResponseModel.data?.items?.fold(
                  0,
                  (previousValue, element) =>
                      previousValue! + (element.price ?? 0)) ??
              0;
          itemQuantities = { for (var item in cartResponseModel.data?.items ?? []) item.id : item.quantity };
        });
      }
    } else {
      Navigator.pop(context, true);
      // if (mounted) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //       content: Text("Failed to load data!"),
      //       backgroundColor: Colors.red,
      //     ),
      //   );
      // }
    }
  }

  Future<void> onTapAddress() async {
    final AddressData? selectedAddress = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AlamatPage(
          selectedAddress: address,
        ),
      ),
    );
    if (selectedAddress != null) {
      setState(() {
        address = selectedAddress;
      });
    }
  }

  void openLink(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not open the URL: $url';
  }
}

  Future<void> addTransaction() async {
    if (address?.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select address first!"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.transactionUrl, {
      "amount": subtotal,
      "item_names": cartResponseModel.data?.items?.map((e) => e.name).toList(),
      "item_prices": cartResponseModel.data?.items?.map((e) => e.price).toList(),
      "item_qtys": itemQuantities.values.toList(),
      "courier_id": 1,
      "address_id": address?.id,
    });
    if (response.isSuccess) {
      transactionResponseModel = PaymentDetailModel.fromJson(response.body!);
      if(transactionResponseModel.success == true) {
        if(mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Transaction added successfully!"),
              backgroundColor: Colors.green,
            ),
          );
        }
        if(transactionResponseModel.data?.paymentUrl != null) {
          getCart();
          openLink(transactionResponseModel.data?.paymentUrl ?? '');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => DetailStatusPesananPage(
                id: transactionResponseModel.data?.transaction?.id ?? 0,
              ),
            ),
          );
          return;
        }
        return;
      } else {
        if(mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(transactionResponseModel.message ?? "Failed to add transaction!"),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to add transaction 2!"),
            backgroundColor: Colors.red,
          ),
        );
      }
      getCart();
    }
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
            Navigator.pop(context, true);
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
              detailPesanan(context),
              const SizedBox(
                height: 32,
              ),
              ButtonCustom(
                label: "Buat Transaksi",
                onTap: () {
                  addTransaction();
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
    final currencyFormatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
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
          itemDetailPesanan(
              context, "Subtotal", currencyFormatter.format(subtotal)),
          const SizedBox(
            height: 10,
          ),
          itemDetailPesanan(context, "Pengiriman", "Rp 100.000"),
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
          // If loading cart, show loading indicator
          if (isLoadingCart)
            const Center(child: CircularProgressIndicator())
          else
            cartResponseModel.data?.items?.isEmpty ?? true
                ? const Center(
                    child: Text("No items in cart"),
                  )
                : Column(
                    children: [
                      for (Item item in cartResponseModel.data!.items!)
                        ItemPesanan(
                          name: item.name ?? '',
                          price: item.price ?? 0,
                          image: item.imageUrl ?? '',
                          initialQuantity:
                              item.quantity ?? 1, // Initial quantity
                          id: item.id ?? 0, // Another item ID
                          onQuantityChanged:
                              _onQuantityChanged, // Pass the callback
                        ),
                    ],
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
              onPressed: () async {
                final int? id = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MethodPaymentPage(),
                  ),
                );

                if (id != null) {
                  // Check if id is not null
                  setState(() {
                    courierID = id;
                  });
                }
              },
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
                      child: GestureDetector(
                    onTap: onTapAddress,
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
                          address?.label ?? "Pilih Alamat Pengantaran..",
                          style: TypographyStyles.regular(12, ColorStyles.grey),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  )),
                ],
              ),
              Positioned(
                right: 0,
                top: 10,
                child: GestureDetector(
                  child: Image.asset(
                    AppAssets.editIcon,
                    width: 24,
                    height: 24,
                  ),
                  onTap: onTapAddress,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          if(address?.notes != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Notes: ${address?.notes}",
                style: TypographyStyles.semiBold(14, ColorStyles.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
