import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final showNewPassword = false.obs;
  final showConfirmPassword = false.obs;
  final isLoading = false.obs;

  void toggleNewPassword() {
    showNewPassword.value = !showNewPassword.value;
  }

  void toggleConfirmPassword() {
    showConfirmPassword.value = !showConfirmPassword.value;
  }

  void submitResetPassword() {
    final newPassword = newPasswordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar('Gagal', 'Semua kolom harus diisi.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (newPassword.length < 8) {
      Get.snackbar('Gagal', 'Sandi harus minimal 8 karakter.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (newPassword != confirmPassword) {
      Get.snackbar('Gagal', 'Konfirmasi sandi tidak cocok.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading.value = true;

    // Simulasi pengiriman perubahan password
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
      Get.snackbar('Berhasil', 'Sandi berhasil diubah.',
          snackPosition: SnackPosition.BOTTOM);

      // Get.offNamed('/login'); // Redirect ke login jika perlu
    });
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
