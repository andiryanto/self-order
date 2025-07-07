import 'package:get/get.dart';

import '../controllers/home_main_controller.dart';
import '../../shop/controllers/shop_controller.dart';

class HomeMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeMainController>(() => HomeMainController());
    Get.lazyPut<ShopController>(() => ShopController());
  }
}
