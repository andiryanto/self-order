import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:self_order/app/modules/notifics/controllers/notifics_controller.dart';
import '../controllers/notifics_controller.dart';

class NotificsView extends GetView<NotificsController> {
  const NotificsView({super.key});

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
      body: const Center(
        child: Text(
          'Empty',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ),
    );
  }
}
