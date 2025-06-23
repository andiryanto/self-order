import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/terms_controller.dart';

class TermsView extends GetView<TermsController> {
  const TermsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syarat dan Ketentuan'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          '''
📜 Syarat dan Ketentuan

1. Pelanggan wajib menggunakan data pribadi yang valid saat mendaftar dan melakukan transaksi.
2. Semua transaksi yang dilakukan melalui aplikasi ini dianggap sah jika telah diverifikasi oleh sistem payment gateway.
3. Produk yang telah dipesan tidak dapat dibatalkan kecuali atas persetujuan dari pihak Pranayama Social Area.
4. Pranayama Social Area berhak menolak transaksi atau menonaktifkan akun pengguna apabila terdeteksi aktivitas mencurigakan.
5. Dengan menggunakan aplikasi ini, Anda menyetujui bahwa data Anda dapat digunakan untuk keperluan pelayanan dan promosi.

Harap membaca ketentuan ini dengan seksama sebelum menggunakan layanan kami.
          ''',
          style: const TextStyle(fontSize: 16, height: 1.6),
        ),
      ),
    );
  }
}
