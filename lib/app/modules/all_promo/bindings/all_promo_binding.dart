import 'package:get/get.dart';

import '../controllers/all_promo_controller.dart';

class AllPromoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllPromoController>(
      () => AllPromoController(),
    );
  }
}
