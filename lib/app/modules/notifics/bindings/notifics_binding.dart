import 'package:get/get.dart';

import '../controllers/notifics_controller.dart';

class NotificsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificsController>(
      () => NotificsController(),
    );
  }
}
