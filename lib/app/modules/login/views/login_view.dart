import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back(); // ganti Navigator.pop
          },
        ),
        title: const Text(
          "Masuk",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 24, left: 24, right: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/images/Pranayama.jpeg', height: 120),
              const SizedBox(height: 80),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Nomor Ponsel*",
                    style: TextStyle(fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 8),
              TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text('+62 '),
                  ),
                  prefixIconConstraints:
                      const BoxConstraints(minWidth: 0, minHeight: 0),
                  prefixStyle: const TextStyle(color: Colors.black),
                  hintText: 'Nomor ponsel anda',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Sandi*",
                    style: TextStyle(fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 8),
              Obx(() => TextField(
                    obscureText: controller.obscurePassword.value,
                    decoration: InputDecoration(
                      hintText: 'Sandi anda',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: const OutlineInputBorder(),
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
                  onPressed: () {
                    // aksi lupa sandi nanti
                  },
                  child: const Text("Lupa sandi?",
                      style: TextStyle(color: Colors.black)),
                ),
              ),
              const SizedBox(height: 32),
              OutlinedButton(
                onPressed: controller.login,
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.black),
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
                child: const Text("Masuk"),
              ),
              const SizedBox(height: 35),
              Column(
                children: [
                  const Text("Belum Punya Akun?"),
                  GestureDetector(
                    onTap: controller.goToRegister,
                    child: const Text(
                      "Daftar Sekarang",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
