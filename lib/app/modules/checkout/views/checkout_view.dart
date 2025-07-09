import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../shop/controllers/shop_controller.dart';
import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({super.key});

  static final fmt =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    final shopC = controller.shopC;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Checkout",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ORDER TYPE STATUS (Dinamis!)
            Container(
              color: Colors.grey[200],
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Obx(() => Center(
                    child: Text(shopC.orderType.value,
                        style: const TextStyle(fontWeight: FontWeight.w500)),
                  )),
            ),

            // ORDER LABEL
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
              child:
                  Text("Order", style: TextStyle(fontWeight: FontWeight.bold)),
            ),

            // LIST ITEM + BOX TOTAL + FOOTER
            Expanded(
              child: Obx(() {
                final items = shopC.items;
                return Column(
                  children: [
                    // --- List Produk ---
                    Expanded(
                      child: items.isEmpty
                          ? const Center(child: Text("Tidak ada item."))
                          : ListView.builder(
                              itemCount: items.length,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              itemBuilder: (context, index) {
                                final item = items[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        item.image,
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) =>
                                            const Icon(Icons.broken_image),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(item.name,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(item.desc,
                                                style: const TextStyle(
                                                    color: Colors.grey)),
                                            const SizedBox(height: 4),
                                            Text(fmt.format(item.price)),
                                            if (item.extras.isNotEmpty)
                                              Text(
                                                "Topping: ${item.extras.join(', ')}",
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black54),
                                              ),
                                            if (item.note.isNotEmpty)
                                              Text(
                                                "Catatan: ${item.note}",
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black45,
                                                    fontStyle:
                                                        FontStyle.italic),
                                              ),
                                          ],
                                        ),
                                      ),
                                      Text("x${item.qty}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ),

                    // --- Total Box (REACTIVE) ---
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Text("Total",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            const Spacer(),
                            Text(fmt.format(shopC.subtotal)),
                          ],
                        ),
                      ),
                    ),

                    // --- Footer (BOTTOM BAR) ---
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            top: BorderSide(color: Colors.grey.shade300)),
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Total',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w600)),
                              Text(fmt.format(shopC.subtotal)),
                            ],
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: controller.toPayment,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                            ),
                            child: const Text("Select Payment"),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
