import 'package:get/get.dart';

import '../controllers/mymenu_controller.dart';

class MymenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MymenuController>(
      () => MymenuController(),
    );
  }
}
