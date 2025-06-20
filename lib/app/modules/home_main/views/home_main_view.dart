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
          transitionBuilder: (child, primaryAnimation, secondatAnimation) {
            return SharedAxisTransition(
                animation: primaryAnimation,
                secondaryAnimation: secondatAnimation,
                transitionType: SharedAxisTransitionType.horizontal,
                fillColor: Colors.white,
                child: child);
          },
          duration: Duration(milliseconds: 300),
          child: controller.page[controller.currentIndex.value],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: (index) {
            controller.changeIndex(index);
          },
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Event'),
            BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Menu'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag), label: 'Shop'),
            BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About'),
          ],
        ),
      ),
    );
  }
}
