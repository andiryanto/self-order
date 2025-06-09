import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  final List<Map<String, String>> onboardingPages = const [
    {
      'title': 'Selamat Datang di Pranayama',
      'subtitle': 'Temukan keseimbangan dalam setiap cangkir',
      'image': 'assets/images/yard.jpg',
    },
    {
      'title': 'Nikmati Suasana Nyaman',
      'subtitle': 'Tempat yang cocok untuk belajar dan bersantai',
      'image': 'assets/images/cup.jpg',
    },
    {
      'title': 'Pesan Mudah dan Cepat',
      'subtitle': 'Gunakan sistem self-order untuk pengalaman terbaik',
      'image': 'assets/images/drink.jpg',
    },
    {
      'title': 'Dukungan Komunitas',
      'subtitle': 'Bergabung dengan komunitas kami dan dapatkan promo menarik',
      'image': 'assets/images/cashier.jpg',
    },
    {
      'title': 'Ayo Mulai!',
      'subtitle': 'Masuk dan rasakan sendiri keuntungannya',
      'image': 'assets/images/hand.jpg',
    },
  ];

  Widget _buildPageIndicator(int currentPage) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(
        onboardingPages.length,
        (int index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == currentPage ? Colors.white : Colors.white54,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Obx(() {
              // langsung pakai controller.currentIndex.value
              return PageView.builder(
                controller: controller.pageController,
                itemCount: onboardingPages.length,
                onPageChanged: controller.onPageChanged,
                itemBuilder: (BuildContext context, int index) {
                  final Map<String, String> page = onboardingPages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          page['image']!,
                          width: 300,
                          height: 300,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          page['title']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          page['subtitle']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
            Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              child:
                  Obx(() => _buildPageIndicator(controller.currentIndex.value)),
            ),
            Positioned(
              bottom: 40,
              left: 24,
              child: TextButton(
                onPressed: () => controller.skip(),
                child: const Text(
                  'Skip',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            Positioned(
              bottom: 40,
              right: 24,
              child: Obx(() => ElevatedButton(
                    onPressed: () => controller.nextPage(),
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(16),
                      backgroundColor: Colors.white,
                    ),
                    child: Icon(
                      controller.currentIndex.value ==
                              onboardingPages.length - 1
                          ? Icons.check
                          : Icons.arrow_forward,
                      color: Colors.black,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
