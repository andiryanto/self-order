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
          onPressed: () {
            Get.offAllNamed(Routes.ONBOARDING); // Back ke onboarding
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
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
        minimum: const EdgeInsets.only(top: 24, left: 24, right: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/images/pranayama.jpeg',
                height: 120,
              ),
              const SizedBox(height: 80),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Nomor Ponsel*",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 8),
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
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                  ),
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Sandi*",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 8),
              Obx(() => TextField(
                    controller: controller.passwordController,
                    obscureText: controller.obscurePassword.value,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      hintText: 'Sandi anda',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                      ),
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
                  child: const Text(
                    "Lupa sandi?",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              OutlinedButton(
                onPressed: controller.login,
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Masuk"),
              ),
              const SizedBox(height: 35),
              Center(
                child: Column(
                  children: [
                    const Text("Belum Punya Akun?"),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.REGISTER);
                      },
                      child: Column(
                        children: [
                          const Text(
                            "Daftar Sekarang",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          Container(
                            height: 0.5,
                            width: 80,
                            color: Colors.blue,
                          ),
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
}
