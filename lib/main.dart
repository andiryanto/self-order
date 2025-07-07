import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'app/modules/shop/controllers/shop_controller.dart';
import 'app/modules/home_main/controllers/home_main_controller.dart';

void main() async {
  Get.put(HomeMainController());
  Get.put(ShopController());
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
