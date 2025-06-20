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
              CircleAvatar(
                backgroundColor: Colors.grey[300],
                child: const Icon(Icons.person, color: Colors.black),
              ),
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
                        decoration: InputDecoration(
                          hintText: 'Search Product',
                          hintStyle: TextStyle(color: Colors.grey),
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
                Wrap(
                  spacing: 8,
                  children: [
                    // Recommended: Icon 👍
                    FilterChip(
                      label: const Icon(Icons.thumb_up,
                          size: 16, color: Colors.black),
                      selected: true,
                      onSelected: (_) {},
                      selectedColor: Colors.white,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Colors.black),
                      ),
                      showCheckmark: false,
                    ),

                    // Coffee
                    FilterChip(
                      label: const Text("Coffee",
                          style: TextStyle(color: Colors.black)),
                      selected: false,
                      onSelected: (_) {},
                      backgroundColor: Colors.white,
                      selectedColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Colors.black),
                      ),
                      showCheckmark: false,
                    ),

                    // Non Coffee
                    FilterChip(
                      label: const Text("Non Coffee",
                          style: TextStyle(color: Colors.black)),
                      selected: false,
                      onSelected: (_) {},
                      backgroundColor: Colors.white,
                      selectedColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Colors.black),
                      ),
                      showCheckmark: false,
                    ),

                    // Manual Brew
                    FilterChip(
                      label: const Text("Manual Brew",
                          style: TextStyle(color: Colors.black)),
                      selected: false,
                      onSelected: (_) {},
                      backgroundColor: Colors.white,
                      selectedColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Colors.black),
                      ),
                      showCheckmark: false,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Recommended",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    DropdownButton<String>(
                      value: controller.selectedOrderType.value,
                      icon: const Icon(Icons.arrow_drop_down),
                      underline: const SizedBox(),
                      style: const TextStyle(color: Colors.black),
                      items: const [
                        DropdownMenuItem(
                          value: "Takeaway",
                          child: Text("Takeaway"),
                        ),
                        DropdownMenuItem(
                          value: "Dine In",
                          child: Text("Dine In"),
                        ),
                      ],
                      onChanged: (value) {
                        controller.selectedOrderType.value = value!;
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                productCard(
                    'Kopi Susu Aren',
                    'Espresso dan susu dengan gula aren',
                    'assets/images/coffee.png',
                    'Rp 23.000'),
                const SizedBox(height: 24),
                sectionHeader('Coffee', '10 Items'),
                productCard('Americano', 'Kopi hitam tanpa gula',
                    'assets/images/coffee.png', 'Rp 18.000'),
                const SizedBox(height: 24),
                sectionHeader('Non Coffee', '10 Items'),
                productCard('Red Velvet', 'Susu dan Red Velvet',
                    'assets/images/coffee.png', 'Rp 23.000'),
              ],
            ),
          ),
        );
      },
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
            onPressed: () {},
            icon: const Icon(Icons.add_box_rounded, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
