import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/shop_controller.dart';
import '../../home_main/controllers/home_main_controller.dart';
import '../../../routes/app_pages.dart';

class ShopView extends GetView<ShopController> {
  const ShopView({super.key});

  static final fmt = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 0,
  );

  /* ---------- WIDGET BANTUAN ---------- */
  Widget _itemImage(String img) => img.startsWith('http')
      ? Image.network(
          img,
          width: 55,
          height: 55,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
        )
      : Image.asset(
          img,
          width: 55,
          height: 55,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
        );

  Widget _addItemButton() => OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.black),
          minimumSize: const Size(80, 40),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        onPressed: () {
          Get.until((route) => route.settings.name == Routes.HOME_MAIN);
          Get.find<HomeMainController>().changeIndex(2);
        },
        child: const Text('Tambah Item', style: TextStyle(color: Colors.black)),
      );

  /* ---------- BUILD ---------- */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.until((route) => route.settings.name == Routes.HOME_MAIN);
            Get.find<HomeMainController>().changeIndex(2);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Shop',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        children: [
          // ✅ ORDER TYPE BAR (DYNAMIC)
          Obx(() => Container(
                width: double.infinity,
                color: Colors.grey[300],
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Center(
                  child: Text(
                    controller.orderType.value,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              )),

          // ---------- LIST ITEM ----------
          Expanded(
            child: Obx(() {
              final items = controller.items;

              if (items.isEmpty) {
                return Center(child: _addItemButton());
              }

              return ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                itemCount: items.length + 1, // ekstra 1 utk tombol
                itemBuilder: (context, index) {
                  if (index == items.length) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: _addItemButton(),
                    );
                  }

                  final item = items[index];
                  return Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _itemImage(item.image),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.edit_outlined,
                                          size: 18),
                                      onPressed: () {
                                        // TODO: edit catatan/topping
                                      },
                                    ),
                                  ],
                                ),
                                Text(
                                  item.desc,
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                                if (item.extras.isNotEmpty)
                                  Text(
                                    'Topping: ${item.extras.join(', ')}',
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.black54),
                                  ),
                                if (item.note.isNotEmpty)
                                  Text(
                                    'Catatan: ${item.note}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black45,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                const SizedBox(height: 6),
                                Text(fmt.format(item.price)),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove, size: 18),
                                    onPressed: () => controller.dec(index),
                                  ),
                                  Text('${item.qty}',
                                      style: const TextStyle(fontSize: 14)),
                                  IconButton(
                                    icon: const Icon(Icons.add, size: 18),
                                    onPressed: () => controller.inc(index),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Divider(height: 24),
                    ],
                  );
                },
              );
            }),
          ),

          // ---------- FOOTER: SUBTOTAL + CHECKOUT ----------
          Obx(() => Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: Colors.grey.shade300, width: 1)),
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Subtotal',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        Text(fmt.format(controller.subtotal)),
                      ],
                    ),
                    const Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      onPressed: () {
                        if (controller.items.isEmpty) {
                          Get.snackbar(
                            'Keranjang Kosong',
                            'Silakan tambahkan item terlebih dahulu sebelum checkout.',
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        } else {
                          Get.toNamed(Routes.CHECKOUT);
                        }
                      },
                      child: const Text('Checkout'),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
