import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final blackOutline = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Ubah Sandi',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Sandi Baru*",
                style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 5),
            Obx(() => TextField(
                  controller: controller.newPasswordController,
                  obscureText: !controller.showNewPassword.value,
                  decoration: InputDecoration(
                    hintText: "Sandi Baru Anda",
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    border: blackOutline,
                    enabledBorder: blackOutline,
                    focusedBorder: blackOutline,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.showNewPassword.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: controller.toggleNewPassword,
                    ),
                  ),
                )),
            const SizedBox(height: 5),
            const Text("✓ Min. 8 Karakter",
                style: TextStyle(color: Colors.black)),
            const SizedBox(height: 20),
            const Text("Konfirmasi Sandi Baru*",
                style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 5),
            Obx(() => TextField(
                  controller: controller.confirmPasswordController,
                  obscureText: !controller.showConfirmPassword.value,
                  decoration: InputDecoration(
                    hintText: "Konfirmasi Sandi Baru Anda",
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    border: blackOutline,
                    enabledBorder: blackOutline,
                    focusedBorder: blackOutline,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.showConfirmPassword.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: controller.toggleConfirmPassword,
                    ),
                  ),
                )),
            const SizedBox(height: 30),
            Obx(() => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.submitResetPassword,
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2)
                        : const Text("Lanjutkan",
                            style: TextStyle(color: Colors.white)),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
