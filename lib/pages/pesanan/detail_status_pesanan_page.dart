import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/data/models/address_detail_model.dart';
import 'package:santapan_fe/data/models/cart_item_model.dart';
import 'package:santapan_fe/data/models/courier_detail_model.dart';
import 'package:santapan_fe/data/models/transaction_detail_model.dart';
import 'package:santapan_fe/data/urls.dart';
import 'package:santapan_fe/models/response_model.dart';
import 'package:santapan_fe/service/network.dart';
import 'package:santapan_fe/widget/button_custom.dart';
import 'package:santapan_fe/widget/item_pesnanan.dart';

class DetailStatusPesananPage extends StatefulWidget {
  final int? id; // Add an id field of type int

  const DetailStatusPesananPage({super.key, this.id}); // Constructor to pass the id

  @override
  State<DetailStatusPesananPage> createState() =>
      _DetailStatusPesananPageState();
}

class _DetailStatusPesananPageState extends State<DetailStatusPesananPage> {
  String status = "pending"; // Example status; change this as needed
  bool isLoading = false;
  CartResponseModel? cartResponseModel;
  AddressDetailModel? addressDetailModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getDetailTransaction();
    });
  }



  TransactionDetail? _transactionDetailModel;
  CourierDetailModel? _courierDetailModel;
  String getTitle() {
    switch (status) {
      case "success":
        return "Pesanan Berhasil";
      case "pending":
        return "Pesanan Diproses";
      case "failed":
        return "Pesanan Gagal";
      default:
        return "Detail Status Pesanan";
    }
  }

  String getSubtitle() {
    switch (status) {
      case "success":
        return "Terima kasih telah memesan di Santapan. Pesanan Anda berhasil!";
      case "pending":
        return "Pesanan Anda sedang diproses. Mohon menunggu konfirmasi.";
      case "failed":
        return "Maaf, pesanan Anda gagal diproses.";
      default:
        return "Status pesanan tidak diketahui.";
    }
  }


  Future<void> getTransactionCart(int cartId) async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    final NetworkResponse response = await NetworkCaller().getRequest("${Urls.cartUrl}/$cartId");
    if (response.isSuccess) {
      cartResponseModel = CartResponseModel.fromJson(response.body!);
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> getDetailTransaction() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    // Correctly use the `id` parameter from the widget
    final NetworkResponse response = await NetworkCaller().getRequest(
        '${Urls.transactionUrl}/${widget.id}'); // Use widget.id as int

    if (response.isSuccess) {
      _transactionDetailModel = TransactionDetail.fromJson(response.body!);
      if (_transactionDetailModel != null) {
        await getTransactionCourier(_transactionDetailModel!.courierId ?? 0);
        await getTransactionCart(_transactionDetailModel!.cartId ?? 0);
        await getTransactionAddress(_transactionDetailModel!.addressId ?? 0);
      }
      if(mounted) {
        setState(() {
          status = _transactionDetailModel!.status;
        });
      }
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


  Future<void> getTransactionAddress(int id) async {
    // Correctly use the `id` parameter from the widget
    final NetworkResponse response = await NetworkCaller().getRequest(
        '${Urls.addressUrl}/1'); // Use widget.id as int

    if (response.isSuccess) {
      addressDetailModel = AddressDetailModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to load data address!"),
          ),
        );
      }
    }
  }

  Future<void> getTransactionCourier(int courierId) async {
      // Correctly use the `id` parameter from the widget
    final NetworkResponse response = await NetworkCaller().getRequest(
        '${Urls.courierUrl}/$courierId'); // Use widget.id as int

    if (response.isSuccess) {
      _courierDetailModel = CourierDetailModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to load data courier!"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Detail Status Pesanan",
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
            children: [
              const SizedBox(height: 24),
              Container(
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: getTitle(),
                                      style: TypographyStyles.bold(
                                          16, ColorStyles.black),
                                    ),
                                    TextSpan(
                                      text: "#sobatSantapan",
                                      style: TypographyStyles.bold(
                                          16, ColorStyles.primary),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                getSubtitle(),
                                style: TypographyStyles.medium(
                                    12, ColorStyles.grey),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Image.asset(
                          AppAssets.pesananSukses,
                          width: 56,
                          height: 56,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Text(
                          "Order ID: TRX - ",
                          style:
                              TypographyStyles.regular(12, ColorStyles.black),
                        ),
                        Text(
                          (_transactionDetailModel?.id.toString() ?? widget.id?.toString() ?? "Loading..."), // Accessing the id here
                          style: TypographyStyles.medium(12, ColorStyles.black),
                        )
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          "Tanggal: ",
                          style:
                              TypographyStyles.regular(12, ColorStyles.black),
                        ),
                        Text(
                          (_transactionDetailModel?.createdAt.toString() ?? "Loading..."), // Accessing the createdAt here
                          style: TypographyStyles.medium(12, ColorStyles.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              alamatInfo(),
              const SizedBox(
                height: 16,
              ),
              daftarPesanan(),
              const SizedBox(
                height: 16,
              ),
              detailPesanan(context),
              const SizedBox(
                height: 24,
              )
            ],
          ),
        ),
      ),
    );
  }

  Container detailPesanan(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
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
          itemDetailPesanan(context, "Pengiriman", currencyFormatter.format(_courierDetailModel?.courier.price ?? 0)),
          const SizedBox(
            height: 10,
          ),
          itemDetailPesanan(context, "Total", currencyFormatter.format(_transactionDetailModel?.amount ?? 0)),
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
        if (isLoading)
          const Center(child: CircularProgressIndicator())
        else
          // Check if there are items in the cart
          cartResponseModel?.data?.items?.isEmpty ?? true
              ? const Center(child: Text("No items in cart"))
              : Column(
                  children: [
                    // Loop through the items in the cart
                    for (var item in cartResponseModel!.data!.items!)
                      ItemPesanan(
                        name: item.name ?? 'Unknown Item',
                        price: item.price ?? 0,
                        image: item.imageUrl ?? '',
                        initialQuantity: item.quantity ?? 1,
                        id: item.id ?? 0,
                      ),
                  ],
                ),
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
                Row(
                  children: [
                    Text(
                      "1x ",
                      style: TypographyStyles.semiBold(14, ColorStyles.black),
                    ),
                    Text(
                      "Nama makanan",
                      style: TypographyStyles.semiBold(14, ColorStyles.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
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
        ],
      ),
    );
  }

  Container alamatInfo() {
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
              children: List.generate(
                  3,
                  (index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Container(
                          width: 4,
                          height: 4,
                          decoration: const BoxDecoration(
                            color: Color(0xFF1C1C1C),
                            shape: BoxShape.circle,
                          ),
                        ),
                      )),
            ),
          ),
          const SizedBox(height: 16),
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
                      style: TypographyStyles.semiBold(14, ColorStyles.black),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      addressDetailModel?.data?.address != null ? "${addressDetailModel?.data?.label} - ${addressDetailModel?.data?.address}" : "Loading...",
                      style: TypographyStyles.regular(12, ColorStyles.grey),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      addressDetailModel?.data?.notes != null ? "Notes: ${addressDetailModel?.data?.notes}" : "Notes: -",
                      style: TypographyStyles.regular(12, ColorStyles.grey),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Notes section
          Text(
            "Notes:",
            style: TypographyStyles.semiBold(14, ColorStyles.black),
          ),
        ],
      ),
    );
  }
}
