// lib/app/modules/mymenu/views/mymenu_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/mymenu_controller.dart';

class MyMenuView extends GetView<MymenuController> {
  const MyMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    final blackOutline = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black),
      borderRadius: BorderRadius.circular(12),
    );

    return GetBuilder<MymenuController>(
      init: MymenuController(),
      builder: (c) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0,
            title: Obx(() => Text(
                  'Halo, ${c.username.value}',
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_none, color: Colors.black),
                onPressed: () => Get.toNamed('/notifics'),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () => Get.toNamed('/account'),
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
                // ─────────────────── Search + Filter ────────────────────
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        cursorColor: Colors.black,
                        onChanged: (v) => c.searchQuery.value = v,
                        decoration: InputDecoration(
                          hintText: 'Search Product',
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: const Icon(Icons.search),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 16),
                          border: blackOutline,
                          enabledBorder: blackOutline,
                          focusedBorder: blackOutline,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton.icon(
                      icon: const Icon(Icons.filter_list),
                      label: const Text('Filter'),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        side: const BorderSide(color: Colors.black),
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () => _showFilterSheet(c),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // ─────────────────── Recommended ────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Recommended',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    Obx(
                      () => DropdownButton<String>(
                        underline: const SizedBox(),
                        value: c.selectedOrderType.value,
                        dropdownColor: Colors.white,
                        items: const [
                          DropdownMenuItem(
                              value: 'Takeaway', child: Text('Takeaway')),
                          DropdownMenuItem(
                              value: 'Dine In', child: Text('Dine In')),
                        ],
                        onChanged: (v) {
                          if (v != null) c.selectedOrderType.value = v;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 140,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    children: [
                      productHorizontalCard(
                          title: 'Kopi Susu Aren',
                          subtitle: 'Espresso + susu + gula aren',
                          price: 'Rp 23.000',
                          image: 'assets/images/coffee.png'),
                      productHorizontalCard(
                          title: 'Caramel Latte',
                          subtitle: 'Kopi susu caramel lembut',
                          price: 'Rp 25.000',
                          image: 'assets/images/coffee.png'),
                      productHorizontalCard(
                          title: 'Manual Brew V60',
                          subtitle: 'Aromatik dan light body',
                          price: 'Rp 28.000',
                          image: 'assets/images/coffee.png'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // ─────────────────── List Menu (API) ────────────────────
                Obx(() {
                  if (c.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final list = c.filteredMenus;
                  if (list.isEmpty) {
                    return const Center(child: Text('Tidak ada menu'));
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: list.length,
                    itemBuilder: (_, i) {
                      final m = list[i];
                      return productCard(
                        m['name'],
                        m['description'] ?? '',
                        'http://127.0.0.1:8000/storage/${m['image']}',
                        'Rp ${m['price']}',
                      );
                    },
                  );
                }),
                const SizedBox(height: 24),
                // ─────────────────── Dummy Static Sections ───────────────
                sectionHeader('Non Coffee', '3 Items'),
                productCard('Red Velvet', 'Susu dan Red Velvet',
                    'assets/images/coffee.png', 'Rp 23.000'),
                productCard('Matcha Latte', 'Susu & bubuk matcha',
                    'assets/images/coffee.png', 'Rp 24.000'),
                productCard('Cokelat', 'Susu dan bubuk cokelat',
                    'assets/images/coffee.png', 'Rp 22.000'),

                const SizedBox(height: 24),

                sectionHeader('Manual Brew', '4 Items'),
                productCard('V60', 'Pour‑over manual brew',
                    'assets/images/coffee.png', 'Rp 28.000'),
                productCard('Japanese', 'Ice brew Jepang',
                    'assets/images/coffee.png', 'Rp 30.000'),
                productCard('Vietnam Drip', 'Kopi khas Vietnam',
                    'assets/images/coffee.png', 'Rp 26.000'),
                productCard('Tubruk', 'Kopi bubuk diseduh langsung',
                    'assets/images/coffee.png', 'Rp 18.000'),

                const SizedBox(height: 24),

                sectionHeader('Snack', '5 Items'),
                productCard('Mixplatter', 'Aneka gorengan & sosis',
                    'assets/images/Plate.jpg', 'Rp 20.000'),
                productCard('Otak‑otak', 'Otak‑otak ikan khas Bintang',
                    'assets/images/Plate.jpg', 'Rp 15.000'),
                productCard('Sosis', 'Sosis ayam goreng',
                    'assets/images/Plate.jpg', 'Rp 13.000'),
                productCard('Kentang Goreng', 'French fries renyah',
                    'assets/images/Plate.jpg', 'Rp 14.000'),
                productCard('Piscok', 'Pisang cokelat goreng',
                    'assets/images/Plate.jpg', 'Rp 10.000'),

                const SizedBox(height: 24),

                sectionHeader('Ricebowl', '3 Items'),
                productCard('Chicken Katsu', 'Nasi + ayam katsu + saus',
                    'assets/images/Ricebowl.png', 'Rp 28.000'),
                productCard(
                    'Chicken Teriyaki',
                    'Nasi + ayam teriyaki manis gurih',
                    'assets/images/Ricebowl.png',
                    'Rp 30.000'),
                productCard('Chicken Black Pepper', 'Nasi + ayam lada hitam',
                    'assets/images/Ricebowl.png', 'Rp 30.000'),
              ],
            ),
          ),
        );
      },
    );
  }

  // ─────────────────────── Helpers & Widgets ──────────────────────────
  void _showFilterSheet(MymenuController c) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Filter',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                'Semua',
                'Coffee',
                'Non Coffee',
                'Snack',
                'Ricebowl',
                'Manual Brew',
              ].map((cat) {
                final selected = c.selectedCategory.value == cat ||
                    (cat == 'Semua' && c.selectedCategory.value == '');
                return ChoiceChip(
                  label: Text(cat,
                      style: TextStyle(
                          color: selected ? Colors.white : Colors.black)),
                  selected: selected,
                  selectedColor: Colors.black,
                  backgroundColor: Colors.white,
                  checkmarkColor: selected ? Colors.white : Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                          color: selected ? Colors.white : Colors.black)),
                  onSelected: (_) {
                    c.selectedCategory.value = cat == 'Semua' ? '' : cat;
                    Get.back();
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionHeader(String title, String subtitle) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(subtitle, style: const TextStyle(color: Colors.grey)),
        ],
      );

  Widget productCard(
          String title, String subtitle, String imageUrl, String price) =>
      Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Row(
          children: [
            Image.network(imageUrl,
                height: 60,
                width: 60,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.broken_image, size: 60)),
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
                icon: const Icon(Icons.add_box_rounded, color: Colors.black),
                onPressed: () => print('Tambah item $title')),
          ],
        ),
      );

  Widget productHorizontalCard(
          {required String title,
          required String subtitle,
          required String price,
          required String image}) =>
      Container(
        width: 220,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
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
                  Text(subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(price,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13)),
                      IconButton(
                        icon: const Icon(Icons.add_box_rounded,
                            color: Colors.black),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () => print('Tambah item $title'),
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
