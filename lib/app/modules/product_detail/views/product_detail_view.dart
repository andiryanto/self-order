import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/product_detail_controller.dart';

class ProductDetailView extends GetView<ProductDetailController> {
  const ProductDetailView({super.key});

  static final fmt =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);

  Widget _headerImage(String path) => path.startsWith('http')
      ? FadeInImage.assetNetwork(
          placeholder: 'assets/images/cup.jpg',
          image: path,
          height: 220,
          width: double.infinity,
          fit: BoxFit.cover,
          imageErrorBuilder: (_, __, ___) => _brokenImage(),
        )
      : Image.asset(
          path,
          height: 220,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _brokenImage(),
        );

  Widget _brokenImage() => Container(
        height: 220,
        color: Colors.grey.shade200,
        alignment: Alignment.center,
        child: const Icon(Icons.broken_image),
      );

  @override
  Widget build(BuildContext context) {
    final c = controller;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Stack(children: [
              _headerImage(c.imagePath),
              Positioned(
                top: 8,
                left: 8,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: Get.back,
                ),
              ),
            ]),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(c.productName,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(c.productDesc),
                    const SizedBox(height: 24),

                    /* ---- EXTRA ---- */
                    const Text('Extra',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Obx(() => Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: c.extras.keys.map((e) {
                            final selected = c.selectedExtras.contains(e);
                            return ChoiceChip(
                              label: Text('$e - ${fmt.format(c.extras[e])}',
                                  textAlign: TextAlign.center),
                              selected: selected,
                              selectedColor: Colors.black,
                              backgroundColor: Colors.white,
                              checkmarkColor:
                                  selected ? Colors.white : Colors.black,
                              labelStyle: TextStyle(
                                  color:
                                      selected ? Colors.white : Colors.black),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(
                                    color: selected
                                        ? Colors.black
                                        : Colors.grey.shade400),
                              ),
                              onSelected: (_) => c.toggleExtra(e),
                            );
                          }).toList(),
                        )),
                    const SizedBox(height: 24),

                    /* ---- CATATAN ---- */
                    const Text('Catatan',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    TextField(
                      cursorColor: Colors.black,
                      maxLines: 2,
                      onChanged: c.setNote, // ← sekarang ada
                      decoration: InputDecoration(
                        hintText: 'Tambah catatan',
                        hintStyle:
                            const TextStyle(color: Colors.grey, fontSize: 14),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /* ---- FOOTER ---- */
            Obx(() => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: const BoxDecoration(
                      border: Border(top: BorderSide(color: Colors.grey))),
                  child: Row(
                    children: [
                      Text(c.totalPriceLabel,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      const Spacer(),
                      IconButton(
                          onPressed: c.decQty, icon: const Icon(Icons.remove)),
                      Text('${c.qty.value}',
                          style: const TextStyle(fontSize: 16)),
                      IconButton(
                          onPressed: c.incQty, icon: const Icon(Icons.add)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            minimumSize: const Size(150, 28),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                          ),
                          onPressed: c.addToCart,
                          child: const FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text('Masukkan Keranjang',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
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
