import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class ForgotPasswordController extends GetxController {
  var showOldPassword = false.obs;
  var showNewPassword = false.obs;
  var showConfirmPassword = false.obs;

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void toggleOldPassword() => showOldPassword.toggle();
  void toggleNewPassword() => showNewPassword.toggle();
  void toggleConfirmPassword() => showConfirmPassword.toggle();

  void submit() {
    final oldPass = oldPasswordController.text.trim();
    final newPass = newPasswordController.text.trim();
    final confirmPass = confirmPasswordController.text.trim();

    if (newPass.length < 8) {
      Get.snackbar("Error", "Password baru minimal 8 karakter");
      return;
    }

    if (newPass != confirmPass) {
      Get.snackbar("Error", "Konfirmasi sandi tidak cocok");
      return;
    }

    // Simulasi proses ubah sandi
    Get.snackbar("Sukses", "Password berhasil diubah",
        snackPosition: SnackPosition.TOP);

    // Navigasi ke login setelah 2 detik
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(Routes.LOGIN);
    });
  }

  @override
  void onClose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
