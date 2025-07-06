// lib/app/modules/mymenu/views/mymenu_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/mymenu_controller.dart';

class MyMenuView extends GetView<MymenuController> {
  const MyMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<MymenuController>();
    final blackOutline = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black),
      borderRadius: BorderRadius.circular(12),
    );

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
            // Search + Filter
            Row(
              children: [
                Expanded(
                  child: TextField(
                    cursorColor: Colors.black,
                    onChanged: (v) {
                      c.searchQuery.value = v;
                    },
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
            Obx(() => Text('Search Query: "${c.searchQuery.value}"')),
            const SizedBox(height: 16),

            // Recommended Header + Order Type
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Recommended',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Obx(
                  () => DropdownButton<String>(
                    underline: const SizedBox(),
                    value: c.selectedOrderType.value,
                    dropdownColor: Colors.white,
                    items: c.orderTypeOptions
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (v) {
                      if (v != null) c.selectedOrderType.value = v;
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Recommended List (dynamic from API)
            Obx(() {
              if (c.recommendedMenus.isEmpty) {
                return const Center(child: Text('Tidak ada rekomendasi'));
              }
              return SizedBox(
                height: 140,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: c.recommendedMenus.length,
                  itemBuilder: (_, i) {
                    final m = c.recommendedMenus[i];
                    return productHorizontalCard(
                      title: m['name'] ?? '',
                      subtitle: m['description'] ?? '',
                      price: 'Rp ${m['price']}',
                      image:
                          m['image'] != null && m['image'].toString().isNotEmpty
                              ? 'http://127.0.0.1:8000/storage/${m['image']}'
                              : 'assets/images/coffee.png',
                    );
                  },
                ),
              );
            }),

            const SizedBox(height: 24),

            // List Menu (filtered & grouped by category)
            Obx(() {
              if (c.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              final list = c.filteredMenus;
              if (list.isEmpty) {
                return const Center(child: Text('Tidak ada menu'));
              }

              // Group menu berdasarkan kategori
              final Map<String, List<Map<String, dynamic>>> groupedMenus = {};
              for (var menu in list) {
                final cat = menu['category'] ?? 'General';
                if (!groupedMenus.containsKey(cat)) {
                  groupedMenus[cat] = [];
                }
                groupedMenus[cat]!.add(menu);
              }

              // Tampilkan kategori dan list menu per kategori
              return ListView(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: groupedMenus.entries.map((entry) {
                  final category = entry.key;
                  final menusByCategory = entry.value;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 4),
                        child: Text(
                          category,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      ...menusByCategory.map((m) {
                        return productCard(
                          m['name'] ?? '',
                          m['description'] ?? '',
                          m['image'] != null && m['image'].toString().isNotEmpty
                              ? 'http://127.0.0.1:8000/storage/${m['image']}'
                              : '',
                          'Rp ${m['price']}',
                        );
                      }).toList(),
                    ],
                  );
                }).toList(),
              );
            }),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// Helpers & Widgets (sama seperti sebelumnya)
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
          imageUrl.isNotEmpty
              ? Image.network(imageUrl,
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.broken_image, size: 60))
              : const Icon(Icons.broken_image, size: 60),
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
          image.isNotEmpty
              ? Image.network(image, height: 60, width: 60, fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                  return Image.asset('assets/images/coffee.png',
                      height: 60, width: 60, fit: BoxFit.cover);
                })
              : Image.asset(image, height: 60, width: 60, fit: BoxFit.cover),
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
