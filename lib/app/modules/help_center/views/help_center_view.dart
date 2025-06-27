import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpCenterView extends StatelessWidget {
  const HelpCenterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // ⬅️ pastikan layar putih
      appBar: AppBar(
        title: const Text(
          'Pusat Bantuan',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Container(
        color: Colors.white, // ⬅️ pastikan body putih
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(16),
        child: const Text(
          '''
📞 Pusat Bantuan

Jika Anda mengalami kendala saat menggunakan aplikasi, silakan hubungi tim kami melalui:

• WhatsApp: 0812-3456-7890
• Email: support@pranayama.co.id
• Instagram: @pranayamaco

Jam operasional bantuan:
Setiap hari pukul 08.00 - 21.00 WIB.

Kami akan segera membantu Anda menyelesaikan permasalahan secepat mungkin. Terima kasih atas kepercayaan Anda.
          ''',
          style: TextStyle(fontSize: 16, height: 1.6),
        ),
      ),
    );
  }
}
