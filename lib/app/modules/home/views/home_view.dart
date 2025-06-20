import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  Widget promoCard(String imagePath) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0,
            title: Obx(() => Text(
                  'Halo, ${controller.username.value}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_none, color: Colors.black),
                onPressed: () => Get.toNamed('/notifics'),
              ),
              const SizedBox(width: 10),
              CircleAvatar(
                backgroundColor: Colors.grey[300],
                child: const Icon(Icons.person, color: Colors.black),
              ),
              const SizedBox(width: 10),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          side: const BorderSide(color: Colors.grey),
                        ),
                        onPressed: () {},
                        child: Container(
                          height: 120,
                          padding: const EdgeInsets.all(12),
                          child: Stack(
                            children: const [
                              Positioned(
                                top: 0,
                                left: 0,
                                child: Text(
                                  'Dine-In',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Icon(
                                  Icons.restaurant,
                                  color: Colors.black,
                                  size: 32,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          side: const BorderSide(color: Colors.grey),
                        ),
                        onPressed: () {},
                        child: Container(
                          height: 120,
                          padding: const EdgeInsets.all(12),
                          child: Stack(
                            children: const [
                              Positioned(
                                top: 0,
                                left: 0,
                                child: Text(
                                  'Takeaway',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Icon(
                                  Icons.shopping_bag,
                                  color: Colors.black,
                                  size: 32,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Promo!',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18)),
                    Text(
                      'See All',
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      promoCard('assets/images/Promo1.jpg'),
                      promoCard('assets/images/Promo2.jpg'),
                      promoCard('assets/images/Promo3.jpg'),
                      promoCard('assets/images/Promo4.jpg'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Antrian!',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Obx(() => Column(
                        children: [
                          const Text('Nomor antrian saat ini:'),
                          Text('${controller.queueNumber.value}',
                              style: const TextStyle(
                                  fontSize: 60, fontWeight: FontWeight.bold)),
                        ],
                      )),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Feedback!',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18)),
                    Text(
                      'See All',
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Obx(() => Column(
                      children: controller.feedbacks
                          .map(
                            (feedback) => Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12, blurRadius: 4)
                                ],
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  feedback,
                                  style: const TextStyle(fontSize: 14),
                                  textAlign: TextAlign.left,
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    )),
              ],
            ),
          ),
          // bottomNavigationBar: BottomNavigationBar(
          //   currentIndex: 0,
          //   onTap: (index) {
          //     switch (index) {
          //       case 0:
          //         // Tetap di Home
          //         break;
          //       case 1:
          //         Get.offAllNamed('/event');
          //         break;
          //       case 2:
          //         Get.offAllNamed('/mymenu');
          //         break;
          //       case 3:
          //         Get.offAllNamed('/shop');
          //         break;
          //       case 4:
          //         Get.offAllNamed('/about');
          //         break;
          //     }
          //   },
          //   backgroundColor: Colors.white,
          //   selectedItemColor: Colors.black,
          //   unselectedItemColor: Colors.grey,
          //   items: const [
          //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          //     BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Event'),
          //     BottomNavigationBarItem(
          //         icon: Icon(Icons.menu_book), label: 'Menu'),
          //     BottomNavigationBarItem(
          //         icon: Icon(Icons.shopping_bag), label: 'Shop'),
          //     BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About'),
          //   ],
          // ),
        );
      },
    );
  }
}
