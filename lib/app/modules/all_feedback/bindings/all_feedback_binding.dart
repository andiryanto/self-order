import 'package:get/get.dart';

import '../controllers/all_feedback_controller.dart';

class AllFeedbackBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllFeedbackController>(
      () => AllFeedbackController(),
    );
  }
}
