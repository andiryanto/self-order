import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../shop/controllers/shop_controller.dart';

class CheckoutController extends GetxController {
  final ShopController shopC = Get.find<ShopController>();

  int get subtotal => shopC.subtotal;

  void toPayment() async {
    final items = shopC.items.map((item) {
      return {
        'name': item.name,
        'price': item.price,
        'qty': item.qty,
        'note': item.note,
        'extras': item.extras,
      };
    }).toList();

    // ✅ Simpan ke variabel body dulu
    final body = {
      'gross_amount': subtotal,
      'name': 'Daffa', // nanti bisa pakai dari user login
      'email': 'daffa@example.com',
      'items': items,
    };

    // ✅ Cetak JSON-nya dulu ke console (untuk dicek)
    print(jsonEncode(body));

    final url = Uri.parse("http://127.0.0.1:8000/api/checkout");

    try {
      final res = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body), // Kirim body-nya di sini
      );

      final data = jsonDecode(res.body);

      if (res.statusCode == 200 && data['redirect_url'] != null) {
        shopC.items.clear();
        Get.offNamed('/payment', arguments: {
          'redirect_url': data['redirect_url'],
        });
      } else {
        Get.snackbar("Error",
            "Gagal membuat transaksi: ${data['error'] ?? 'Unknown error'}");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    }
  }
}
