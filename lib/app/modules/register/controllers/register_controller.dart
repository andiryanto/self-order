import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final referralController = TextEditingController();

  var obscurePassword = true.obs;
  var agreeTerms = false.obs;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleAgreeTerms() {
    agreeTerms.value = !agreeTerms.value;
  }

  void register() {
    if (_isValidForm()) {
      Get.snackbar("Berhasil", "Pendaftaran berhasil!",
          backgroundColor: Colors.green, colorText: Colors.white);
      Get.offAllNamed('/home'); // replace with your home route
    } else {
      Get.snackbar(
          "Gagal", "Mohon lengkapi semua data dan setujui syarat ketentuan",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  bool _isValidForm() {
    return nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        agreeTerms.value;
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    referralController.dispose();
    super.onClose();
  }
}
