import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/notifics_controller.dart';
import 'package:intl/intl.dart';

class NotificsView extends GetView<NotificsController> {
  const NotificsView({super.key});

  String formatTime(String raw) {
    final time = DateTime.tryParse(raw);
    if (time == null) return '';
    return DateFormat('dd MMM yyyy, HH:mm').format(time);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Notifications',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      backgroundColor: Colors.white,
      body: Obx(() {
        if (controller.notifications.isEmpty) {
          return const Center(
            child: Text(
              'Tidak ada notifikasi',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return RefreshIndicator(
          color: Colors.white, // ← warna loading indicator
          backgroundColor: Colors.black, // ← warna latar bulatannya (opsional)
          onRefresh: () async {
            await controller.fetchNotifications();
          },
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            itemCount: controller.notifications.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final notif = controller.notifications[index];
              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 2),
                  ],
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    notif['title'] ?? '-',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(
                        notif['message'] ?? '',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        formatTime(notif['timestamp'] ?? ''),
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
