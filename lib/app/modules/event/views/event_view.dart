// event_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/event_controller.dart';

class EventView extends GetView<EventController> {
  const EventView({super.key});

  @override
  Widget build(BuildContext context) {
    final blackOutline = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black),
      borderRadius: BorderRadius.circular(12),
    );

    return GetBuilder<EventController>(
      init: EventController(),
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
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        cursorColor: Colors.black,
                        onChanged: (value) =>
                            controller.searchQuery.value = value,
                        decoration: InputDecoration(
                          hintText: 'Search Event',
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
                      onPressed: () {
                        Get.bottomSheet(
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20)),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Filter',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 12),
                                Wrap(
                                  spacing: 8,
                                  children: [
                                    'Semua',
                                    'Musik',
                                    'Pameran',
                                    'Workshop',
                                    'Lainnya',
                                  ].map((category) {
                                    final isSelected = controller
                                                .selectedCategory.value ==
                                            category ||
                                        (category == 'Semua' &&
                                            controller.selectedCategory.value ==
                                                '');
                                    return ChoiceChip(
                                      label: Text(
                                        category,
                                        style: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      selected: isSelected,
                                      selectedColor: Colors.black,
                                      backgroundColor: Colors.white,
                                      checkmarkColor: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: BorderSide(
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      onSelected: (selected) {
                                        controller.selectedCategory.value =
                                            category == 'Semua' ? '' : category;
                                        Get.back();
                                      },
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.filter_list),
                      label: const Text('Filter'),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: const BorderSide(color: Colors.black),
                        foregroundColor: Colors.black,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Program Event',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Obx(() => ListView.builder(
                        itemCount: controller.filteredEvents.length,
                        itemBuilder: (context, index) {
                          final event = controller.filteredEvents[index];
                          final imageUrl = (event['image'] != null &&
                                  event['image'].toString().isNotEmpty)
                              ? 'http://10.0.2.2:8000/storage/${event['image']}'
                              : 'assets/images/default_event.png';

                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                  child: Image.network(
                                    imageUrl,
                                    width: double.infinity,
                                    height: 180,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Image.asset(
                                      'assets/images/default_event.png',
                                      height: 180,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        event['name'] ?? '',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        event['date'] ?? '',
                                        style: const TextStyle(
                                            color: Colors.black87),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Kategori: ${event['category'] ?? ''}',
                                        style: const TextStyle(
                                            fontStyle: FontStyle.italic,
                                            color: Colors.black54),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      )),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
