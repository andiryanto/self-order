import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:self_order/app/routes/app_pages.dart';

class OnboardingController extends GetxController {
  final RxInt currentIndex = 0.obs;
  final PageController pageController = PageController();

  // 2 buah state animasi button
  final isLoginButtonPressed = false.obs;
  final isRegisterButtonPressed = false.obs;

  final List<Map<String, String>> onboardingPages = [
    {
      'title': 'Hai, Kaum Prana',
      'subtitle': 'Selamat Datang di aplikasi Pranayama Social Area',
      'extra': 'FIND BALANCE IN EVERY CUP.',
      'image': 'assets/images/yard.jpg',
    },
    {
      'title': 'Bukan cuma enak, tapi menguntungkan',
      'subtitle': 'Jajan hemat dengan promo dan harga special Kaum Prana',
      'image': 'assets/images/cup.jpg',
    },
    {
      'title': 'Lebih dekat dengan info terupdate',
      'subtitle': 'Khusus untuk kamu Kaum Prana',
      'image': 'assets/images/drink.jpg',
    },
    {
      'title': 'Cukup Scan dan Bayar, tanpa antre',
      'subtitle': 'Solusi modern untuk pelayanan lebih cepat dan akurat',
      'image': 'assets/images/cashier.jpg',
    },
    {
      'title': 'Pranayama Social Area',
      'subtitle': 'FIND BALANCE EVERY CUP',
      'image': 'assets/images/hand.jpg',
    },
  ];

  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  void nextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void skip() {
    Future.delayed(const Duration(milliseconds: 300), () {
      Get.offAllNamed(Routes.HOME_MAIN);
    });
  }

  // fungsi untuk animasi login button
  Future<void> handleLoginButtonPress() async {
    isLoginButtonPressed.value = true;
    await Future.delayed(const Duration(milliseconds: 150));
    isLoginButtonPressed.value = false;
    await Future.delayed(const Duration(milliseconds: 100));
    Get.offAllNamed(Routes.LOGIN);
  }

  // fungsi untuk animasi register button
  Future<void> handleRegisterButtonPress() async {
    isRegisterButtonPressed.value = true;
    await Future.delayed(const Duration(milliseconds: 150));
    isRegisterButtonPressed.value = false;
    await Future.delayed(const Duration(milliseconds: 100));
    Get.offAllNamed(Routes.REGISTER);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
