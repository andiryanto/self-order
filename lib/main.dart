import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'app/modules/home_main/controllers/home_main_controller.dart';
import 'package:self_order/app/data/models/user_model.dart';

void main() async {
  final dummyUser = UserModel(
    name: 'Ryan',
    email: 'ryan@example.com',
    phone: '081234567890',
    gender: 'Laki-laki',
    image: '', // atau bisa default avatar path
  );
  Get.put(HomeMainController());
  Get.put(dummyUser);

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
