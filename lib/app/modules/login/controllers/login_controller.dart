import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:self_order/app/routes/app_pages.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  /* ---------- Form Controller ---------- */
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  /* ---------- UI State ---------- */
  final obscurePassword = true.obs;
  final isLoading = false.obs;

  /* ---------- Storage & Base URL ---------- */
  final box = GetStorage();
  final baseUrl = 'http://127.0.0.1:8000'; // ganti ke IP/URL backend kamu

  /* ---------- Toggle password visibility ---------- */
  void togglePasswordVisibility() => obscurePassword.toggle();

  /* ---------- LOGIN ACTION ---------- */
  Future<void> login() async {
    final phone = phoneController.text.trim();
    final password = passwordController.text.trim();

    if (phone.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Mohon lengkapi semua data',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isLoading(true);
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/api/login'),
        body: {'phone': phone, 'password': password},
      );

      final data = json.decode(res.body);

      if (res.statusCode == 200 && data['token'] != null) {
        // ✅ Simpan token & data user
        await box.write('token', data['token']);
        await box.write('username', data['user']['name']);
        await box.write('phone', data['user']['phone']);
        await box.write('image_url', data['user']['image_url'] ?? '');

        // ✅ Navigasi ke home
        Get.offAllNamed(Routes.HOME_MAIN);
        Get.snackbar('Sukses', 'Login berhasil',
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar('Gagal', data['message'] ?? 'Login gagal',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading(false);
    }
  }

  /* ---------- Cleanup ---------- */
  @override
  void onClose() {
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
