import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/onboarding_controller.dart';
import 'package:self_order/app/routes/app_pages.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  Widget _buildPageIndicator(int currentPage, int totalPages) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(
        totalPages,
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
    final pages = controller.onboardingPages;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: controller.pageController,
              itemCount: pages.length,
              onPageChanged: controller.onPageChanged,
              itemBuilder: (context, index) {
                final page = pages[index];
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      page['image']!,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.3),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 60),
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
                          const SizedBox(height: 6),
                          Text(
                            page['subtitle']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          if (page.containsKey('extra')) ...[
                            const SizedBox(height: 6),
                            Text(
                              page['extra']!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (index == pages.length - 1)
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Obx(() => SizedBox(
                                  width: width * 0.8,
                                  child: ElevatedButton(
                                    onPressed:
                                        controller.handleLoginButtonPress,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      elevation: 0,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        side: const BorderSide(
                                            color: Colors.white, width: 1),
                                      ),
                                    ),
                                    child: Opacity(
                                      opacity:
                                          controller.isLoginButtonPressed.value
                                              ? 0.5
                                              : 1,
                                      child: const Text(
                                        'Masuk',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                            const SizedBox(height: 8),
                            Obx(() => SizedBox(
                                  width: width * 0.8,
                                  child: ElevatedButton(
                                    onPressed:
                                        controller.handleRegisterButtonPress,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        side: const BorderSide(
                                            color: Colors.white, width: 1),
                                      ),
                                    ),
                                    child: Opacity(
                                      opacity: controller
                                              .isRegisterButtonPressed.value
                                          ? 0.5
                                          : 1,
                                      child: const Text(
                                        'Daftar',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                  ],
                );
              },
            ),
            Obx(() {
              if (controller.currentIndex.value != pages.length - 1) {
                return Positioned(
                  bottom: 100,
                  left: 0,
                  right: 0,
                  child: _buildPageIndicator(
                      controller.currentIndex.value, pages.length),
                );
              } else {
                return const SizedBox();
              }
            }),
            Obx(() {
              if (controller.currentIndex.value != pages.length - 1) {
                return Positioned(
                  bottom: 40,
                  left: 24,
                  child: TextButton(
                    onPressed: () {
                      controller.skip();
                    },
                    child: const Text(
                      'Skip',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            }),
            Obx(() {
              if (controller.currentIndex.value != pages.length - 1) {
                return Positioned(
                  bottom: 40,
                  right: 24,
                  child: TextButton(
                    onPressed: controller.nextPage,
                    child: const Text(
                      'Next',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            }),
            Obx(() {
              if (controller.currentIndex.value == pages.length - 1) {
                return Positioned(
                  bottom: 60,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.HOME);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Skip this step',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Container(
                            height: 0.5,
                            width: 80,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            }),
          ],
        ),
      ),
    );
  }
}
