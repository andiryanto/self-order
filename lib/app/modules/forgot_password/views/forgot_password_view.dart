import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final blackOutline = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Ubah Sandi',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sandi Lama
            const Text("Sandi Lama*",
                style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 5),
            Obx(() => TextField(
                  cursorColor: Colors.black,
                  obscureText: !controller.showOldPassword.value,
                  controller: controller.oldPasswordController,
                  decoration: InputDecoration(
                    hintText: "Sandi Lama Anda",
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                    ),
                    enabledBorder: blackOutline,
                    focusedBorder: blackOutline,
                    border: blackOutline,
                    suffixIcon: IconButton(
                      icon: Icon(controller.showOldPassword.value
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () => controller.toggleOldPassword(),
                    ),
                  ),
                )),
            const SizedBox(height: 20),

            // Sandi Baru
            const Text("Sandi Baru*",
                style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 5),
            Obx(() => TextField(
                  cursorColor: Colors.black,
                  obscureText: !controller.showNewPassword.value,
                  controller: controller.newPasswordController,
                  decoration: InputDecoration(
                    hintText: "Sandi Baru Anda",
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                    ),
                    enabledBorder: blackOutline,
                    focusedBorder: blackOutline,
                    border: blackOutline,
                    suffixIcon: IconButton(
                      icon: Icon(controller.showNewPassword.value
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () => controller.toggleNewPassword(),
                    ),
                  ),
                )),
            const SizedBox(height: 5),
            const Text("✓ Min. 8 karakter",
                style: TextStyle(color: Colors.black)),

            const SizedBox(height: 20),

            // Konfirmasi Sandi Baru
            const Text("Konfirmasi Sandi Baru*",
                style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 5),
            Obx(() => TextField(
                  cursorColor: Colors.black,
                  obscureText: !controller.showConfirmPassword.value,
                  controller: controller.confirmPasswordController,
                  decoration: InputDecoration(
                    hintText: "Konfirmasi Sandi Baru Anda",
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                    ),
                    enabledBorder: blackOutline,
                    focusedBorder: blackOutline,
                    border: blackOutline,
                    suffixIcon: IconButton(
                      icon: Icon(controller.showConfirmPassword.value
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () => controller.toggleConfirmPassword(),
                    ),
                  ),
                )),

            const SizedBox(height: 30),

            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: controller.submit,
                  child: const Text("Lanjutkan",
                      style: TextStyle(color: Colors.white)),
                ))
          ],
        ),
      ),
    );
  }
}
