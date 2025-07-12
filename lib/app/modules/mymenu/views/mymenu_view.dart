import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shop/controllers/shop_controller.dart';
import '../controllers/mymenu_controller.dart';
import 'package:badges/badges.dart' as badges;
import 'package:self_order/app/modules/notifics/controllers/notifics_controller.dart';

class MyMenuView extends GetView<MymenuController> {
  const MyMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<MymenuController>();
    final shopC = Get.find<ShopController>();
    final notificsController = Get.put(NotificsController());

    final blackOutline = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black),
      borderRadius: BorderRadius.circular(12),
    );

    void _openDetail(Map<String, dynamic> data) {
      final image = (data['image'] ?? '').toString();
      final imagePath = image.isNotEmpty
          ? 'http://127.0.0.1:8000/storage/$image'
          : 'assets/images/coffee.png';

      final rawPrice = data['price'];

      int parsedPrice;

      if (rawPrice is int) {
        parsedPrice = rawPrice;
      } else if (rawPrice is String) {
        // Tangani string desimal seperti "23000.00"
        parsedPrice = double.tryParse(rawPrice)?.toInt() ?? 0;
      } else {
        parsedPrice = 0;
      }
      Get.toNamed('/product-detail', arguments: {
        'name': data['name'],
        'desc': data['description'],
        'price': parsedPrice,
        'image': imagePath,
        'extras': data['extras'] ?? {},
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Obx(() => Text(
              'Halo, ${c.username.value.isEmpty ? 'User' : c.username.value}',
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            )),
        actions: [
          Obx(() {
            final count = notificsController.notifications.length;
            return badges.Badge(
              showBadge: count > 0,
              badgeContent: Text(
                '$count',
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
              position: badges.BadgePosition.topEnd(top: 0, end: 3),
              badgeStyle: const badges.BadgeStyle(
                badgeColor: Colors.red,
                padding: EdgeInsets.all(5),
              ),
              child: IconButton(
                icon: const Icon(Icons.notifications_none, color: Colors.black),
                onPressed: () => Get.toNamed('/notifics'),
              ),
            );
          }),
          const SizedBox(width: 10),
          GestureDetector(
              onTap: () => Get.toNamed('/account'),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey[300],
                child: const Icon(Icons.person, color: Colors.white),
              )),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                      if (v != null) {
                        c.selectedOrderType.value = v;
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Obx(() {
              if (c.recommendedMenus.isEmpty) return const SizedBox();
              return SizedBox(
                height: 140,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: c.recommendedMenus.length,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemBuilder: (_, i) {
                    final m = c.recommendedMenus[i];
                    final image = (m['image'] ?? '').toString();
                    final imagePath = image.isNotEmpty
                        ? 'http://127.0.0.1:8000/storage/$image'
                        : 'assets/images/coffee.png';

                    return productHorizontalCard(
                      data: m,
                      title: m['name'] ?? '',
                      subtitle: m['description'] ?? '',
                      price: 'Rp ${m['price']}',
                      imageUrl: imagePath,
                      onTap: () => _openDetail(m),
                    );
                  },
                ),
              );
            }),
            const SizedBox(height: 24),
            Obx(() {
              if (c.isLoading.value)
                return const Center(child: CircularProgressIndicator());

              final list = c.filteredMenus;
              if (list.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Center(
                    child: Column(
                      children: const [
                        SizedBox(height: 12),
                        Text('Produk tidak ditemukan',
                            style: TextStyle(fontSize: 16, color: Colors.grey)),
                      ],
                    ),
                  ),
                );
              }

              final Map<String, List<Map<String, dynamic>>> grouped = {};
              for (final m in list) {
                final cat = (m['category'] ?? 'General').toString();
                grouped.putIfAbsent(cat, () => []).add(m);
              }

              return ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: grouped.entries.map((e) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(e.key,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                      ),
                      ...e.value.map((m) {
                        final image = (m['image'] ?? '').toString();
                        final imagePath = image.isNotEmpty
                            ? 'http://127.0.0.1:8000/storage/$image'
                            : 'assets/images/coffee.png';

                        return productCard(
                          data: m,
                          title: m['name'] ?? '',
                          subtitle: m['description'] ?? '',
                          imageUrl: imagePath,
                          price: 'Rp ${m['price']}',
                          onTap: () => _openDetail(m),
                        );
                      }),
                    ],
                  );
                }).toList(),
              );
            }),
          ],
        ),
      ),
    );
  }
}

void _showFilterSheet(MymenuController c) {
  final categories = [
    'Semua',
    'Coffee',
    'Non Coffee',
    'Snack',
    'Ricebowl',
    'Manual Brew'
  ];

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
            children: categories.map((cat) {
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
                  side:
                      BorderSide(color: selected ? Colors.white : Colors.black),
                ),
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

Widget productCard({
  required Map<String, dynamic> data,
  required String title,
  required String subtitle,
  required String imageUrl,
  required String price,
  required VoidCallback onTap,
}) =>
    InkWell(
      onTap: onTap,
      child: Container(
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
                  Text(subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.grey)),
                  Text(price,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const Icon(Icons.add_box_rounded, color: Colors.black),
          ],
        ),
      ),
    );

Widget productHorizontalCard({
  required Map<String, dynamic> data,
  required String title,
  required String subtitle,
  required String price,
  required String imageUrl,
  required VoidCallback onTap,
}) =>
    InkWell(
      onTap: onTap,
      child: Container(
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
            imageUrl.startsWith('http')
                ? Image.network(imageUrl,
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Image.asset(
                        'assets/images/coffee.png',
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover))
                : Image.asset(imageUrl,
                    height: 60, width: 60, fit: BoxFit.cover),
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
                      const Icon(Icons.add_box_rounded, color: Colors.black),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
