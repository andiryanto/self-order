import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import 'package:self_order/app/routes/app_pages.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.offAllNamed(Routes.ONBOARDING),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Masuk",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/images/pranayama.jpeg', height: 120),
              const SizedBox(height: 80),

              /* ---------- Nomor Ponsel ---------- */
              _label("Nomor Ponsel*"),
              TextField(
                controller: controller.phoneController,
                keyboardType: TextInputType.phone,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  prefixIcon: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text('+62 '),
                  ),
                  prefixIconConstraints:
                      const BoxConstraints(minWidth: 0, minHeight: 0),
                  hintText: 'Nomor ponsel anda',
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              /* ---------- Password ---------- */
              _label("Sandi*"),
              Obx(() => TextField(
                    controller: controller.passwordController,
                    obscureText: controller.obscurePassword.value,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      hintText: 'Sandi anda',
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(controller.obscurePassword.value
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                    ),
                  )),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Get.toNamed(Routes.FORGOT_PASSWORD),
                  child: const Text("Lupa sandi?",
                      style: TextStyle(color: Colors.black)),
                ),
              ),
              const SizedBox(height: 32),

              /* ---------- Tombol Login ---------- */
              Obx(() => SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton(
                      onPressed:
                          controller.isLoading.value ? null : controller.login,
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2)
                          : const Text("Masuk"),
                    ),
                  )),
              const SizedBox(height: 35),

              /* ---------- Arah ke Register ---------- */
              Center(
                child: Column(
                  children: [
                    const Text("Belum punya akun?"),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () => Get.toNamed(Routes.REGISTER),
                      child: Column(
                        children: [
                          const Text("Daftar Sekarang",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue)),
                          Container(
                              height: 0.5, width: 100, color: Colors.blue),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  /* ---------- Helper label ---------- */
  Widget _label(String text) => Align(
        alignment: Alignment.centerLeft,
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
      );
}
