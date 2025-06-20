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
              CircleAvatar(
                backgroundColor: Colors.grey[300],
                child: const Icon(Icons.person, color: Colors.black),
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
                        decoration: InputDecoration(
                          hintText: 'Search Event',
                          hintStyle: TextStyle(color: Colors.grey),
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
                        itemCount: controller.events.length,
                        itemBuilder: (context, index) {
                          final event = controller.events[index];
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
                                  child: Image.asset(
                                    event.image,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        event.title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        event.date,
                                        style: const TextStyle(
                                            color: Colors.black87),
                                      ),
                                      const SizedBox(height: 4),
                                      const Text(
                                        'Live Music at Pranayama',
                                        style: TextStyle(
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
          // bottomNavigationBar: BottomNavigationBar(
          //   currentIndex: 1,
          //   onTap: (index) {
          //     switch (index) {
          //       case 0:
          //         Get.offAllNamed('/home');
          //         break;
          //       case 1:
          //         // Tetap di Event
          //         break;
          //       case 2:
          //         Get.offAllNamed('/mymenu');
          //         break;
          //       case 3:
          //         Get.offAllNamed('/shop');
          //         break;
          //       case 4:
          //         Get.offAllNamed('/about');
          //         break;
          //     }
          //   },
          //   backgroundColor: Colors.white,
          //   selectedItemColor: Colors.black,
          //   unselectedItemColor: Colors.grey,
          //   items: const [
          //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          //     BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Event'),
          //     BottomNavigationBarItem(
          //         icon: Icon(Icons.menu_book), label: 'Menu'),
          //     BottomNavigationBarItem(
          //         icon: Icon(Icons.shopping_bag), label: 'Shop'),
          //     BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About'),
          //   ],
          // ),
        );
      },
    );
  }
}
