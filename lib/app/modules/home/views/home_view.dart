import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'package:self_order/app/modules/home_main/controllers/home_main_controller.dart';
import 'package:self_order/app/modules/mymenu/controllers/mymenu_controller.dart';
import 'package:self_order/app/modules/notifics/controllers/notifics_controller.dart';
import 'package:badges/badges.dart' as badges;

const String _baseUrl = 'http://127.0.0.1:8000';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MymenuController(), fenix: true);
    final notificsController = Get.put(NotificsController());

    return GetBuilder<HomeController>(
      init: HomeController(),
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
                    icon: const Icon(Icons.notifications_none,
                        color: Colors.black),
                    onPressed: () => Get.toNamed('/notifics')?.then((_) {
                      controller.fetchQueueNumber(); // ✅ update setelah kembali
                    }),
                  ),
                );
              }),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () => Get.toNamed("/account")?.then((_) {
                  controller.fetchQueueNumber(); // ✅ update setelah kembali
                }),
                child: CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  child: const Icon(Icons.person, color: Colors.black),
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              await controller.fetchQueueNumber();
              await controller.fetchFeedbacks();
              await controller.fetchPromos();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Dine-In dan Takeaway
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            side: const BorderSide(color: Colors.grey),
                            overlayColor: Colors.black26,
                          ),
                          onPressed: () {
                            Get.find<MymenuController>()
                                .selectedOrderType
                                .value = 'Dine In';
                            Get.find<HomeMainController>().changeIndex(2);
                            controller
                                .fetchQueueNumber(); // ✅ update jika kembali ke home
                          },
                          child: Container(
                            height: 120,
                            padding: const EdgeInsets.all(12),
                            child: Stack(
                              children: const [
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Text(
                                    'Dine-In',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Icon(Icons.restaurant,
                                      color: Colors.black, size: 32),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            side: const BorderSide(color: Colors.grey),
                            overlayColor: Colors.black26,
                          ),
                          onPressed: () {
                            Get.find<MymenuController>()
                                .selectedOrderType
                                .value = 'Takeaway';
                            Get.find<HomeMainController>().changeIndex(2);
                            controller
                                .fetchQueueNumber(); // ✅ update jika kembali ke home
                          },
                          child: Container(
                            height: 120,
                            padding: const EdgeInsets.all(12),
                            child: Stack(
                              children: const [
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Text(
                                    'Takeaway',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Icon(Icons.shopping_bag,
                                      color: Colors.black, size: 32),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // PROMO
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Promo!',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18)),
                      GestureDetector(
                        onTap: () => Get.toNamed('/all-promo')?.then((_) {
                          controller.fetchQueueNumber(); // ✅ optional update
                        }),
                        child: const Text('See All',
                            style: TextStyle(color: Colors.grey)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 150,
                    child: Obx(() {
                      if (controller.promos.isEmpty) {
                        return const Center(child: Text('Belum ada promo'));
                      }
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.promos.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 10),
                        itemBuilder: (context, index) {
                          final promo = controller.promos[index];
                          return Container(
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                    offset: Offset(0, 2)),
                              ],
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                '$_baseUrl/storage/${promo['promo_image']}',
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => const Center(
                                    child: Icon(Icons.broken_image)),
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),

                  const SizedBox(height: 20),

                  // ANTRIAN
                  const Text('Antrian!',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 4)
                      ],
                    ),
                    child: Obx(() => Column(
                          children: [
                            const Text('Nomor antrian saat ini:'),
                            Text(
                              '${controller.queueNumber.value}',
                              style: const TextStyle(
                                  fontSize: 60, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                  ),

                  const SizedBox(height: 20),

                  // FEEDBACK
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Feedback!',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18)),
                      GestureDetector(
                        onTap: () => Get.toNamed('/all-feedback'),
                        child: const Text('See All',
                            style: TextStyle(color: Colors.grey)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Obx(() => Column(
                        children: controller.feedbacks
                            .take(2)
                            .map(
                              (feedback) => Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black12, blurRadius: 4)
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 4),
                                    Text(
                                      feedback['message'] ?? '',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
