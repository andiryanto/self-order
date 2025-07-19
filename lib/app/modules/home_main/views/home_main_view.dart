import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_main_controller.dart';
import 'package:animations/animations.dart';

class HomeMainView extends GetView<HomeMainController> {
  const HomeMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        body: PageTransitionSwitcher(
          transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
            return SharedAxisTransition(
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
              fillColor: Colors.white,
              child: child,
            );
          },
          duration: const Duration(milliseconds: 300),
          child: controller.page[controller.currentIndex.value],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeIndex,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          elevation: 8,
          items: [
            const BottomNavigationBarItem(
                icon: Icon(Icons.home), label: 'Home'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.event), label: 'Event'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.menu_book), label: 'Menu'),

            // SHOP + badge
            BottomNavigationBarItem(
              icon: Obx(() => Stack(
                    children: [
                      const Icon(Icons.shopping_bag),
                      if (controller.cartItemCount.value > 0)
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 12,
                              minHeight: 12,
                            ),
                            child: Text(
                              controller.cartItemCount.value.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  )),
              label: 'Shop',
            ),

            const BottomNavigationBarItem(
                icon: Icon(Icons.info), label: 'About'),
          ],
        ),
      ),
    );
  }
}
