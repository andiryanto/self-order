import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/mymenu_controller.dart';

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
            controller: controller.scrollController,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search & Filter
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        cursorColor: Colors.black,
                        onChanged: controller.updateSearch,
                        decoration: InputDecoration(
                          hintText: 'Search Product',
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: const Icon(Icons.search),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 16),
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
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.filter_list),
                      label: const Text('Filter'),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: const BorderSide(color: Colors.black),
                        foregroundColor: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Filter Chip
                Wrap(
                  spacing: 8,
                  children: [
                    buildIconFilterChip(
                        Icons.thumb_up,
                        controller.selectedCategory.value == "Recommended",
                        controller,
                        "Recommended"),
                    buildTextFilterChip(
                        "Coffee",
                        controller.selectedCategory.value == "Coffee",
                        controller),
                    buildTextFilterChip(
                        "Non Coffee",
                        controller.selectedCategory.value == "Non Coffee",
                        controller),
                    buildTextFilterChip(
                        "Manual Brew",
                        controller.selectedCategory.value == "Manual Brew",
                        controller),
                  ],
                ),
                const SizedBox(height: 24),

                // Recommended
                sectionHeader('Recommended',
                    '${controller.recommendedProducts.length} Items'),
                Obx(() => Column(
                      key: controller.recommendedKey,
                      children: controller.recommendedProducts.map((product) {
                        return productCard(
                          product.title,
                          product.subtitle,
                          product.image,
                          product.price,
                        );
                      }).toList(),
                    )),
                const SizedBox(height: 24),

                sectionHeader('All Products',
                    '${controller.filteredProducts.length} Items'),
                Obx(() => Column(
                      children: controller.filteredProducts.map((product) {
                        return productCard(
                          product.title,
                          product.subtitle,
                          product.image,
                          product.price,
                        );
                      }).toList(),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildTextFilterChip(
      String label, bool selected, MymenuController controller) {
    return FilterChip(
      label: Text(label, style: const TextStyle(color: Colors.black)),
      selected: selected,
      onSelected: (_) => controller.updateCategory(label),
      backgroundColor: Colors.white,
      selectedColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Colors.black),
      ),
      showCheckmark: false,
    );
  }

  Widget buildIconFilterChip(IconData icon, bool selected,
      MymenuController controller, String category) {
    return FilterChip(
      label: Icon(icon, size: 16, color: Colors.black),
      selected: selected,
      onSelected: (_) => controller.updateCategory(category),
      selectedColor: Colors.white,
      backgroundColor: Colors.white,
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
          Image.asset(image, height: 60),
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
}
