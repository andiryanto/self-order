import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/mymenu_controller.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyMenuView extends GetView<MymenuController> {
  const MyMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MymenuController>(
      init: MymenuController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0,
            title: Obx(() => Text(
                  'Halo, ${controller.username.value}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_none, color: Colors.black),
                onPressed: () => Get.toNamed('/notifics'),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () => Get.toNamed("/account"),
                child: CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  child: const Icon(Icons.person, color: Colors.black),
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Box Only
                TextField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: 'Search Product',
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(Icons.search),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Filter Chip
                Wrap(
                  spacing: 8,
                  children: [
                    buildFilterChip(Icons.thumb_up, true),
                    buildTextFilterChip("Coffee", false),
                    buildTextFilterChip("Non Coffee", false),
                    buildTextFilterChip("Manual Brew", false),
                    buildTextFilterChip("Snack", false),
                    buildTextFilterChip("Ricebowl", false),
                  ],
                ),
                const SizedBox(height: 16),

                // Recommended + Dropdown
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Recommended",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Obx(() => DropdownButton<String>(
                          value: controller.selectedOrderType.value,
                          icon: const Icon(Icons.arrow_drop_down),
                          underline: const SizedBox(),
                          dropdownColor: Colors.white,
                          style: const TextStyle(color: Colors.black),
                          items: const [
                            DropdownMenuItem(
                                value: "Takeaway", child: Text("Takeaway")),
                            DropdownMenuItem(
                                value: "Dine In", child: Text("Dine In")),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              controller.selectedOrderType.value = value;
                            }
                          },
                        )),
                  ],
                ),
                const SizedBox(height: 8),

                // Horizontal scroll Recommended
                SizedBox(
                  height: 140,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    scrollDirection: Axis.horizontal,
                    children: [
                      productHorizontalCard(
                        title: 'Kopi Susu Aren',
                        subtitle: 'Espresso + susu + gula aren',
                        price: 'Rp 23.000',
                        image: 'assets/images/coffee.png',
                      ),
                      productHorizontalCard(
                        title: 'Caramel Latte',
                        subtitle: 'Kopi susu caramel lembut',
                        price: 'Rp 25.000',
                        image: 'assets/images/coffee.png',
                      ),
                      productHorizontalCard(
                        title: 'Manual Brew V60',
                        subtitle: 'Aromatik dan light body',
                        price: 'Rp 28.000',
                        image: 'assets/images/coffee.png',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // Kalau kosong bisa tampilkan pesan
                  if (controller.menus.isEmpty) {
                    return const Center(child: Text('Belum ada menu'));
                  }

                  // ▸ Pilih salah satu:
                  // 1. ListView (scroll sendiri) – cocok kalau produk banyak
                  return ListView.builder(
                    shrinkWrap: true, // jika di dalam NestedScrollView/Column
                    physics: const ClampingScrollPhysics(),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: controller.menus.length,
                    itemBuilder: (context, index) {
                      final item = controller.menus[index];

                      return productCard(
                        item['name'],
                        item['description'] ?? '',
                        'http://127.0.0.1:8000/storage/${item['image']}',
                        'Rp ${item['price']}',
                      );
                    },
                  );
                }),
                const SizedBox(height: 24),

                // Non Coffee
                sectionHeader('Non Coffee', '3 Items'),
                productCard('Red Velvet', 'Susu dan Red Velvet',
                    'assets/images/coffee.png', 'Rp 23.000'),
                productCard('Matcha Latte', 'Susu & bubuk matcha',
                    'assets/images/coffee.png', 'Rp 24.000'),
                productCard('Cokelat', 'Susu dan bubuk cokelat',
                    'assets/images/coffee.png', 'Rp 22.000'),

                const SizedBox(height: 24),

                // Manual Brew
                sectionHeader('Manual Brew', '4 Items'),
                productCard('V60', 'Pour over manual brew',
                    'assets/images/coffee.png', 'Rp 28.000'),
                productCard('Japanese', 'Ice brew Jepang',
                    'assets/images/coffee.png', 'Rp 30.000'),
                productCard('Vietnam Drip', 'Kopi khas Vietnam',
                    'assets/images/coffee.png', 'Rp 26.000'),
                productCard('Tubruk', 'Kopi bubuk diseduh langsung',
                    'assets/images/coffee.png', 'Rp 18.000'),

                const SizedBox(height: 24),

                // Snack
                sectionHeader('Snack', '5 Items'),
                productCard('Mixplatter', 'Aneka gorengan dan sosis',
                    'assets/images/Plate.jpg', 'Rp 20.000'),
                productCard('Otak-otak', 'Otak-otak ikan khas Bintang',
                    'assets/images/Plate.jpg', 'Rp 15.000'),
                productCard('Sosis', 'Sosis ayam goreng',
                    'assets/images/Plate.jpg', 'Rp 13.000'),
                productCard('Kentang Goreng', 'French fries renyah',
                    'assets/images/Plate.jpg', 'Rp 14.000'),
                productCard('Piscok', 'Pisang cokelat goreng',
                    'assets/images/Plate.jpg', 'Rp 10.000'),

                const SizedBox(height: 24),

                // Ricebowl
                sectionHeader('Ricebowl', '3 Item'),
                productCard(
                    'Ricebowl Chicken Katsu',
                    'Nasi + ayam katsu + saus',
                    'assets/images/Ricebowl.png',
                    'Rp 28.000'),
                productCard(
                    'Ricebowl Chicken Teriyaki',
                    'Nasi + ayam teriyaki manis gurih',
                    'assets/images/Ricebowl.png',
                    'Rp 30.000'),
                productCard(
                    'Ricebowl Chicken BlackPaper',
                    'Nasi + ayam lada hitam pedas gurih',
                    'assets/images/Ricebowl.png',
                    'Rp 30.000'),
              ],
            ),
          ),
        );
      },
    );
  }

  // Components
  Widget buildFilterChip(IconData icon, bool selected) {
    return FilterChip(
      label: Icon(icon, size: 16, color: Colors.black),
      selected: selected,
      onSelected: (_) {},
      selectedColor: Colors.white,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Colors.black),
      ),
      showCheckmark: false,
    );
  }

  Widget buildTextFilterChip(String label, bool selected) {
    return FilterChip(
      label: Text(label, style: const TextStyle(color: Colors.black)),
      selected: selected,
      onSelected: (_) {},
      backgroundColor: Colors.white,
      selectedColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Colors.black),
      ),
      showCheckmark: false,
    );
  }

  Widget sectionHeader(String title, String subtitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(subtitle, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget productCard(
      String title, String subtitle, String image, String price) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        children: [
          Image.network(
            image,
            height: 60,
            width: 60,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.broken_image,
                  size: 60, color: Colors.red);
            },
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(subtitle, style: const TextStyle(color: Colors.grey)),
                Text(price,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              print('Tambah item $title');
            },
            icon: const Icon(Icons.add_box_rounded, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget productHorizontalCard({
    required String title,
    required String subtitle,
    required String price,
    required String image,
  }) {
    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(image, height: 60, width: 60, fit: BoxFit.cover),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(price,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13)),
                    IconButton(
                      onPressed: () {
                        print('Tambah item $title');
                      },
                      icon: const Icon(Icons.add_box_rounded,
                          color: Colors.black),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
