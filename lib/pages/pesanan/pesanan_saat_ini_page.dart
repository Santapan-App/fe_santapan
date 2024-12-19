import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/data/models/history_model.dart';
import 'package:santapan_fe/data/urls.dart';
import 'package:santapan_fe/models/response_model.dart';
import 'package:santapan_fe/service/network.dart';
import 'package:santapan_fe/widget/order_card.dart';

class PesananSaatIniPage extends StatefulWidget {
  const PesananSaatIniPage({super.key});

  @override
  State<PesananSaatIniPage> createState() => _PesananSaatIniPageState();
}

class _PesananSaatIniPageState extends State<PesananSaatIniPage> {
  bool isLoading = false;
  OngoingResponse? ongoingResponse;

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
          await NetworkCaller().getRequest(Urls.transactionUrl + "/ongoing");
      if (response.isSuccess) {
        setState(() {
          ongoingResponse = OngoingResponse.fromJson(response.body!);
        });
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
          : ongoingResponse == null || ongoingResponse!.data.isEmpty
              ? const Center(child: Text("No ongoing orders found."))
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        ...ongoingResponse!.data.map((transaction) => Column(
                              children: [
                                OrderCard(
                                  date: _formatDate(transaction.createdAt),
                                  status: transaction.status.toUpperCase(),
                                  totalPrice: "Rp${transaction.amount}", orderId: 1,
                                ),
                                const SizedBox(height: 16),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
    );
  }
}
