import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/history_transaction_controller.dart';

class HistoryTransactionView extends GetView<HistoryTransactionController> {
  const HistoryTransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Riwayat Transaksi',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.transactions.isEmpty) {
          return const Center(child: Text('Belum ada transaksi'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.transactions.length,
          itemBuilder: (context, index) {
            final trx = controller.transactions[index];
            final items = trx['items'] ?? [];

            return Card(
              color: Colors.white,
              elevation: 3,
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'No. Transaksi: ${trx['no_transaction']}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text('Nomor Antrian: ${trx['no_antrian'] ?? '-'}'),
                    Text('Tanggal: ${trx['created_at'] ?? '-'}'),
                    Text('Tipe: ${trx['type_transaction'] ?? '-'}'),
                    Text('Staff: ${trx['staff']?['name'] ?? '-'}'),
                    Text(
                      'Total: ${currencyFormat.format(double.tryParse(trx['total_price'].toString()) ?? 0)}',
                    ),
                    const Divider(height: 24),
                    const Text(
                      'Daftar Produk:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ...items.map<Widget>((item) {
                      // ✅ Parsing extras
                      List<String> extras = [];
                      if (item['extras'] != null &&
                          item['extras'].toString().isNotEmpty) {
                        try {
                          extras =
                              List<String>.from(jsonDecode(item['extras']));
                        } catch (e) {
                          extras = [item['extras'].toString()];
                        }
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${item['nama_produk']} x${item['qty']} - ${currencyFormat.format(double.tryParse(item['subtotal'].toString()) ?? 0)}',
                            ),
                            if (extras.isNotEmpty)
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 2.0),
                                child: Text(
                                  'Extras: ${extras.join(', ')}',
                                  style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              ),
                            if (item['note'] != null &&
                                item['note'].toString().isNotEmpty)
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 2.0),
                                child: Text(
                                  'Catatan: ${item['note']}',
                                  style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
