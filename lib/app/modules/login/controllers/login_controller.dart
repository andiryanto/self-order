import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  var obscurePassword = true.obs;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void login() {
    // Nanti logika login aslinya di sini
    String phone = phoneController.text;
    String password = passwordController.text;

    if (phone.isNotEmpty && password.isNotEmpty) {
      Get.snackbar("Sukses", "Login berhasil!",
          backgroundColor: Colors.green, colorText: Colors.white);
      Get.offAllNamed('/home'); // misalnya ke halaman home
    } else {
      Get.snackbar("Error", "Mohon isi semua field",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  void onClose() {
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
