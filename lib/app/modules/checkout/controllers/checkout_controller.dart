import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

import '../../shop/controllers/shop_controller.dart';

class CheckoutController extends GetxController {
  final ShopController shopC = Get.find<ShopController>();

  final box = GetStorage(); // ✅ Gunakan GetStorage (sama dengan Login)

  int get subtotal => shopC.subtotal;

  void toPayment() async {
    final token = box.read('token'); // ✅ Ambil token dari GetStorage

    if (token == null) {
      Get.snackbar("Auth Error", "Token tidak ditemukan. Silakan login ulang.");
      return;
    }

    final items = shopC.items.map((item) {
      return {
        'name': item.name,
        'price': item.price,
        'qty': item.qty,
        'note': item.note,
        'extras': item.extras,
      };
    }).toList();

    final body = {
      'gross_amount': subtotal,
      'name': 'Daffa', // Optional: ambil dari user profile kalau ada
      'email': 'daffa@example.com',
      'type_transaction': shopC.orderType.value,
      'items': items,
    };

    print(jsonEncode(body)); // ✅ Debug untuk melihat isi JSON

    final url = Uri.parse("http://127.0.0.1:8000/api/checkout");

    try {
      final res = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token', // ✅ Kirim token ke Laravel
        },
        body: jsonEncode(body),
      );

      final data = jsonDecode(res.body);

      if (res.statusCode == 200 && data['redirect_url'] != null) {
        shopC.items.clear(); // Kosongkan keranjang
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
