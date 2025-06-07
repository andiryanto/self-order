import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:self_order/app/routes/app_pages.dart';

class SplashController extends GetxController {
  // final emailController = TextEditingController();
  // final passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    startTime();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // emailController.dispose();
    // passwordController.dispose();
    super.onClose();
  }

  Future<void> startTime() async {
    Future.delayed(Duration(seconds: 3)).then((_) {
      Get.offAllNamed(Routes.ONBOARDING);
    });
  }

  // void login() {
  //   String email = emailController.text.trim();
  //   String password = passwordController.text;

  //   if (email.isEmpty || password.isEmpty) {
  //     Get.snackbar("Error", "Email dan Password tidak boleh kosong",
  //         snackPosition: SnackPosition.BOTTOM);
  //     return;
  //   }

  //   // Simulasi login
  //   if (email == "admin@example.com" && password == "123456") {
  //     Get.offAllNamed(Routes.HOME); // Arahkan ke home jika berhasil
  //   } else {
  //     Get.snackbar("Login Gagal", "Email atau password salah",
  //         snackPosition: SnackPosition.BOTTOM);
  //   }
  // }
}
