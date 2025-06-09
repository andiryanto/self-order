import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  final currentIndex = 0.obs;
  late final PageController pageController;

  final int totalPages = 5;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void nextPage() {
    if (pageController.hasClients) {
      if (currentIndex.value < totalPages - 1) {
        pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      } else {
        // Misal: langsung ke halaman login/home
        Get.offAllNamed('/login');
      }
    }
  }

  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  void skip() {
    Get.offAllNamed('/login');
  }
}
