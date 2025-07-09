import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/all_promo_controller.dart';

const String _baseUrl = 'http://127.0.0.1:8000';

class AllPromoView extends GetView<AllPromoController> {
  const AllPromoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Promo',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Obx(() {
        if (controller.promoList.isEmpty) {}

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.promoList.length,
          itemBuilder: (context, index) {
            final promo = controller.promoList[index];
            return promoCard(promo);
          },
        );
      }),
    );
  }

  Widget promoCard(Map<String, dynamic> promo) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar promo
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                '$_baseUrl/storage/${promo['promo_image']}',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    const Center(child: Icon(Icons.broken_image)),
              ),
            ),
          ),
          // Informasi promo
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Teks judul promo tetap kiri
                Text(
                  promo['name'] ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(promo['description'] ?? ''),
                const SizedBox(height: 8),
                Text(
                  'Periode: ${promo['start_date']} - ${promo['expiried_date']}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
