import 'package:get/get.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;
  //TODO: Implement OnboardingController

  void setCurrentPage(int page) {
    currentPage.value = page;
  }
}
