import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/product_detail_controller.dart';

class ProductDetailView extends GetView<ProductDetailController> {
  const ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = controller; // alias singkat
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            /* -------- HEADER (gambar + back) -------- */
            Stack(
              children: [
                Image.asset(
                  c.imagePath,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Get.back(),
                  ),
                ),
              ],
            ),

            /* -------- DETAIL CONTENT -------- */
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          c.productName,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(c.productDesc),
                        const SizedBox(height: 24),

                        /* ------ EXTRA / TOPPING ------ */
                        const Text('Extra',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: c.extras.keys.map((e) {
                            final selected = c.selectedExtras.contains(e);
                            return ChoiceChip(
                              label: Text('$e\n+Rp${c.extras[e]!.toString()}',
                                  textAlign: TextAlign.center),
                              selected: selected,
                              selectedColor: Colors.black,
                              labelStyle: TextStyle(
                                  color:
                                      selected ? Colors.white : Colors.black),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: const BorderSide(color: Colors.black)),
                              onSelected: (_) => c.toggleExtra(e),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 24),

                        /* ------ CATATAN ------ */
                        const Text('Catatan',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        TextField(
                          cursorColor: Colors.black,
                          maxLines: 2,
                          decoration: InputDecoration(
                            hintText: 'Tambah catatan',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ),

            /* -------- FOOTER -------- */
            Obx(() => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: const BoxDecoration(
                      border: Border(top: BorderSide(color: Colors.grey))),
                  child: Row(
                    children: [
                      Text('Rp${c.totalPrice}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      const Spacer(),
                      IconButton(
                          onPressed: c.decQty, icon: const Icon(Icons.remove)),
                      Text(c.qty.value.toString(),
                          style: const TextStyle(fontSize: 16)),
                      IconButton(
                          onPressed: c.incQty, icon: const Icon(Icons.add)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          onPressed: c.addToCart,
                          child: const Text('Masukkan Keranjang',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
