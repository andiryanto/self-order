import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:self_order/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  var obscurePassword = true.obs;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void login() {
    String phone = phoneController.text;
    String password = passwordController.text;

    if (phone.isNotEmpty && password.isNotEmpty) {
      Get.snackbar("Sukses", "Login berhasil!",
          backgroundColor: Colors.green, colorText: Colors.white);
      Get.offAllNamed(Routes.HOME_MAIN);
    } else {
      Get.snackbar("Error", "Mohon lengkapi semua data",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
