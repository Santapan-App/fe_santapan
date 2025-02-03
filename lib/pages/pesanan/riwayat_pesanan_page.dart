import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/data/models/finish_transaction_model.dart';
import 'package:santapan_fe/data/urls.dart';
import 'package:santapan_fe/models/response_model.dart';
import 'package:santapan_fe/pages/pesanan/detail_status_pesanan_page.dart';
import 'package:santapan_fe/service/network.dart';
import 'package:santapan_fe/widget/order_card.dart';

class RiwayatPesananPage extends StatefulWidget {
  const RiwayatPesananPage({super.key});

  @override
  State<RiwayatPesananPage> createState() => _RiwayatPesananPageState();
}

class _RiwayatPesananPageState extends State<RiwayatPesananPage> {
  bool isLoading = false;
  FinishTransactionResponseModel? finishTransactionResponse;

  @override
  void initState() {
    super.initState();
    getHistories();
  }

  Future<void> getHistories() async {
    setState(() {
      isLoading = true;
    });

    try {
      final NetworkResponse response =
          await NetworkCaller().getRequest(Urls.transactionUrl);
      if (response.isSuccess) {
        finishTransactionResponse =
            FinishTransactionResponseModel.fromJson(response.body!);
      } else {
        _showErrorSnackbar("Failed to load transaction data!");
      }
    } catch (e) {
      _showErrorSnackbar("An error occurred while fetching data!");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showErrorSnackbar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy HH:mm').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : finishTransactionResponse == null || finishTransactionResponse!.data == null || finishTransactionResponse!.data.isEmpty
              ? const Center(child: Text("No completed or canceled orders found."))
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        ...finishTransactionResponse!.data.map((transaction) => Column(
                                  children: [
                                    OrderCard(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailStatusPesananPage(
                                              id: transaction.id,
                                            ),
                                          ),
                                        );
                                      },
                                      date: _formatDate(transaction.createdAt),
                                      status: transaction.status.toUpperCase(),
                                      totalPrice: "Rp${transaction.amount}",
                                      orderId: transaction.id,
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                ))
                            .toList(),
                      ],
                    ),
                  ),
                ),
    );
  }
}
