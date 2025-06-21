import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/all_feedback_controller.dart';

class AllFeedbackView extends GetView<AllFeedbackController> {
  const AllFeedbackView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white, // warna status bar
        statusBarIconBrightness: Brightness.dark, // ikon status bar jadi hitam
      ),
      child: Scaffold(
        backgroundColor: Colors.white, // background body putih
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0, // hilangkan shadow AppBar
            centerTitle: true,
            foregroundColor: Colors.black,
            automaticallyImplyLeading: true,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
            title: const Text(
              'Feedback',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
        ),
        body: Obx(() => ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: homeController.feedbacks.length,
              itemBuilder: (context, index) {
                final feedback = homeController.feedbacks[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 2),
                    ],
                  ),
                  child: Text(
                    feedback,
                    style: const TextStyle(fontSize: 14),
                  ),
                );
              },
            )),
      ),
    );
  }
}
