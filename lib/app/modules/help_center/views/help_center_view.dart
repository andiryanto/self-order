import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpCenterView extends StatelessWidget {
  const HelpCenterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pusat Bantuan'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
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
          style: const TextStyle(fontSize: 16, height: 1.6),
        ),
      ),
    );
  }
}
