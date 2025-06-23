import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final isLoading = false.obs;

  bool isValidEmail(String email) {
    return GetUtils.isEmail(email);
  }

  void sendResetLink() {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      Get.snackbar('Gagal', 'Email tidak boleh kosong.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (!isValidEmail(email)) {
      Get.snackbar('Gagal', 'Format email tidak valid.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading.value = true;

    // Simulasi pengiriman tautan reset
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;

      Get.snackbar(
          'Berhasil', 'Tautan reset kata sandi telah dikirim ke email Anda.',
          snackPosition: SnackPosition.BOTTOM);

      // Contoh: arahkan ke login setelah berhasil
      // Get.offNamed('/login');
    });
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
