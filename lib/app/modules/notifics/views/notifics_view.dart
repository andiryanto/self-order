import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/notifics_controller.dart';

class NotificsView extends GetView<NotificsController> {
  const NotificsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NotificsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'NotificsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
