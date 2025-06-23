import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kebijakan Privasi'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          '''
🔒 Kebijakan Privasi

Privasi Anda adalah hal yang penting bagi kami. Kami berkomitmen untuk menjaga dan melindungi informasi pribadi Anda.

• Data yang dikumpulkan hanya digunakan untuk keperluan layanan pemesanan dan pembayaran.
• Kami tidak akan membagikan data Anda kepada pihak ketiga tanpa persetujuan Anda.
• Seluruh data ditransmisikan melalui koneksi yang aman dan terenkripsi.
• Anda memiliki hak untuk mengakses, mengubah, atau menghapus data pribadi Anda kapan saja.

Dengan menggunakan aplikasi ini, Anda menyetujui kebijakan privasi yang telah ditetapkan.
          ''',
          style: const TextStyle(fontSize: 16, height: 1.6),
        ),
      ),
    );
  }
}
