import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  final RxInt currentIndex = 0.obs;
  final PageController pageController = PageController();

  final List<Map<String, String>> onboardingPages = [
    {
      'title': 'Hai, Kaum Prana',
      'subtitle': 'Selamat Datang di aplikasi Pranayama Social Area',
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
    if (currentIndex.value == onboardingPages.length - 1) {
      // TODO: Ganti dengan halaman tujuanmu setelah onboarding selesai
      Get.offAllNamed('/login');
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void skip() {
    // TODO: Ganti dengan halaman tujuanmu jika user klik 'Skip'
    Get.offAllNamed('/login');
  }
}
