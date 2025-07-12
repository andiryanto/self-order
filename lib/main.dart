import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'app/modules/shop/controllers/shop_controller.dart';
import 'app/modules/home_main/controllers/home_main_controller.dart';
import 'app/modules/history_transaction/controllers/history_transaction_controller.dart';
import 'app/modules/account/controllers/account_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(HomeMainController());
  Get.lazyPut(() => ShopController(), fenix: true);
  Get.lazyPut(() => HistoryTransactionController(), fenix: true);
  Get.put(AccountController(), permanent: true);

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
